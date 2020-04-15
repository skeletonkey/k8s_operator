# k8s_operator
Talk and example about Kubernetes Operators

## Requirements

### Software

These requirements are adapted and stolen from [Demystifying Kubernetes Operators with the Operator SDK: Part2](https://www.linux.com/training-tutorials/demystifying-kubernetes-operators-operator-sdk-part-2/)
* [golang](https://golang.org/dl/) v1.10+
* [dep](https://golang.github.io/dep/docs/installation.html) v0.5.0+
* [git](https://git-scm.com/downloads)
* [docker](https://docs.docker.com/get-docker/) v17.03+
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) v1.10.0+
* An account on [DockerHub](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
  * There is a way of doing local Docker repo, but I haven't taken the time to prove this out
* [operatro-sdk](https://github.com/operator-framework/operator-sdk/blob/master/doc/user/install-operator-sdk.md)
* [microk8s](https://microk8s.io/#get-started)
  * Some have reported a conflict with `minikube`, however, I haven't run into this.


### Alias

**All examples assume you have done this!!!**

It is recommend that in a shell that you create the following alias:
```shell script
alias kubectl="microk8s kubectl"
```
Please do *not* create this as a default (part of your .profile or .bashrc) since you will probably need `kubectl` for other work and this alias will bite you in the butt.

## K8s REST Interface

```shell script
kubectl config view
```

There you will find the server endpoint: `https://127.0.0.1/16443`

The user is `admin`.

The password is plain text.



