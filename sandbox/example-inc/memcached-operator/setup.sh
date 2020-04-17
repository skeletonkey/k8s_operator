microk8s kubectl create -f deploy/service_account.yaml
microk8s kubectl create -f deploy/role.yaml
microk8s kubectl create -f deploy/role_binding.yaml
microk8s kubectl create -f deploy/operator.yaml
