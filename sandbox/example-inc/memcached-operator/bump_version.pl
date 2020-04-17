#!/usr/bin/perl -s

use strict;
use warnings;
use vars qw($r);

use Data::Dumper;

$r ||= 0; # redeploy (don't increment version)

my $dockerhub_user = 'erik2029';
my $operator_file = 'deploy/operator.yaml';
my $version_prefix = 'v0.0.';

my $line = `grep "0.0." deploy/operator.yaml`;

my ($current_version) = $line =~ /\.(\d+)$/;
die("Unable to determine current version from: $line\n") unless $current_version;
my $new_version = $r ? $current_version : $current_version + 1;

$current_version = $version_prefix . $current_version;
$new_version = $version_prefix . $new_version;

if ($r) {
    print ("Redeploying version $current_version\n");
}
else {
    print ("Bumping version from $current_version to $new_version\n");
}

print ("Building ...");
my @lines = `operator-sdk build $dockerhub_user/memcached-operator:$new_version`;
if (!@lines || $lines[-1] !~ /Successfully tagged.+?($new_version)/) {
    print("Build did not complete properly for $new_version: \n");
    Dumper(\@lines);
    exit(1);
}

print ("\nPushing ...");
@lines = `docker push $dockerhub_user/memcached-operator:$new_version`;
if (!@lines || $lines[-1] !~ /^$new_version: digest: (sha256:.+?) /) {
    print("Push did not complete properly: \n");
    Dumper(\@lines);
    exit(1);
}
if (!$r) {
    print " $1\nIncrementing version in $operator_file ...";
    `sed -i 's/$current_version/$new_version/' $operator_file`;
}

print "\nApplying:\n";
print `microk8s kubectl apply -f deploy/operator.yaml`, "\n";