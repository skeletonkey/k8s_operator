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

## References

* [What is a K8s operator](https://www.bmc.com/blogs/kubernetes-operator/)

### Best Practices

 * [Best practices for building K8s Operators and stateful apps](https://cloud.google.com/blog/products/containers-kubernetes/best-practices-for-building-kubernetes-operators-and-stateful-apps)
 * [Taking a Kubernetes Operator to Production](https://itnext.io/taking-a-kubernetes-operator-to-production-bc59708db420)

### Misc

 * [K8s Standardized Glossary](https://kubernetes.io/docs/reference/glossary/?all=true)
 
### SDKs

 * [Kubebuilder](https://github.com/kubernetes-sigs/kubebuilder)
    * [Kubebuilder Book](https://book.kubebuilder.io/)
 * [K8s Universal Declarative Operator (KUDO)](https://kudo.dev/)
 * [Operator Framework](https://github.com/operator-framework/getting-started)
    * used to create the sandbox

#### Non-SDK

If the SDKs do not provide enough fine control feel free to take a look at [ClientGo](https://github.com/kubernetes/client-go)
    
### Testing

#### Ginkgo

An article about [Ginkgo - A Golan BDD Testing Framework](https://itnext.io/testing-kubernetes-operators-with-ginkgo-gomega-and-the-operator-runtime-6ad4c2492379)
[Ginkgo's repo](https://github.com/onsi/ginkgo)
