# Sandbox

This example and sandbox uses [Operator Framework](https://github.com/operator-framework/getting-started)


This sandbox was built on a Ubuntu Linux box, however, if you follow the step below you should be able  recreate thing on an OS - given that the requirements have been installed (see main [README.md](https://github.com/skeletonkey/k8s_operator))

## Get it running

### Copy

You should be able to simply copy the example-inc directory to `$GOPATH/src/gitbub.com/example-inc`.  I tried putting it elsewhere initially, but ran into all types of directory and dependency issues.
```shell script
ln -s $GIT_REPO_LOC/k8s_operator/sandbox/example-inc $GOPATH/src/github.com/
```

#### Getup and running

Apply the following:
```shell script
cd $GOPATH/src/github.com/example-inc/memcached-operator
kubectl apply -f deploy/crds/cache.example.com_memcacheds_crd.yaml
kubectl apply -f deploy/crds/cache.example.com_v1alpha1_memcached_cr.yaml
kubectl apply -f deploy/operator.yaml
kubectl apply -f deploy/role_binding.yaml
kubectl apply -f deploy/role.yaml
kubectl apply -f deploy/service_account.yaml
```
NOTE: it's assumed that you've run `alias kubectl="microk8s kubectl"`

#### Clean up
```shell script
cd $GOPATH/src/github.com/example-inc/memcached-operator
kubectl delete -f deploy/crds/cache.example.com_memcacheds_crd.yaml
kubectl delete -f deploy/crds/cache.example.com_v1alpha1_memcached_cr.yaml
kubectl delete -f deploy/operator.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/service_account.yaml
```


### Manually Build

To manually build the sandbox following the [operator-framework - getting-started instruction](https://github.com/operator-framework/getting-started).

Under the `Build and run the operator` section's step one make sure that you remove mention of `quay.io`.  Use dockerhub's image registry to hold your images.

## Interacting

### See Pods
```shell script
kubectl get pods --namespace default
```

Keep an eye on them as they change:
```shell script
watch -n 1 microk8s kubectl get pods --namespace default
```
In this case you will need to specify `microk8s` even if you've created an alias.

You'll see several pods named `example-memcahce-xxxxx`.  Those are the service containers.

One will be titled `memcached-operator-xxxxxx` - this is the pod containing the operator.  This is the pod that you will want to watch for logging.

### See Operator's Logs
```shell script
kubectl logs -f memcached-operator-xxxxxx
```

### Making a change to the Operator 

Once a change has been made to the operator (IE: pkg/controller/memcached/memcached_controller.go) it will need to be rebuilt, push to dockerhub and apply.

For the follwing examples the enviornmental variable DOCKER_USER is your dockerhub's user name and $VERSION is the next version.

#### Rebuild
```shell script
operator-sdk build $DOCKER_USER/memcached-operator:$VERSION
```

#### Push to Dockerhub
```shell script
docker push $DOCKER_USER/memcached-operator:$VERSION
```

#### Update version and apply
```shell script
sed -i 's/$OLD_VERSION/$VERSION/' deploy/operator.yaml
kubectl apply -f deploy/operator.yaml
```

If you've been watching the operator's logs you'll notice that you have been disconnect.  This is because the old operator is being killed and a new operator pod is being started up.  You'll need to get its name and run the command to read the new pod's logs.
