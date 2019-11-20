# Overview

This will setup the keptn-orders demo app without Istio or Keptn.  The application overview can be viewed
[here](https://github.com/keptn-orders/keptn-orders-setup#demo-application)

# Setup

1. Have a Dynatrace tenant
1. Create a cluster and install Dynatrace OneAgent Operator.  My testing was on Azure where use these scripts:
```
https://github.com/keptn-workshops/workshop-utils/tree/0.5.1/scripts
```
1. Install kubectl and connect to cluster.  For example on Azure:
```
az aks get-credentials --resource-group jahn-keptn-workshop-group --name jahn-keptn-workshop-cluster
```
1. Clone this repo and run these commands
```
kubectl create ns <your namespace>

# apply app chart files
kubectl -n keptn-orders apply -R -f .

# apply just one for example:
kubectl -n <your namespace> apply front-end.yaml
```
1. Monitor pods.  You should see this:
```
kubectl -n <your namespace> get pods
NAME                                READY   STATUS    RESTARTS   AGE
catalog-service-9bd57f66c-zw445     1/1     Running   0          6m48s
customer-service-7bd5687fd7-mlr2d   1/1     Running   0          6m48s
front-end-8699dd574f-vcwzn          1/1     Running   0          6m47s
order-service-657b698d96-vhw5m      1/1     Running   0          6m47s
```
1. Get the external IP for the front-end
```
kubectl -n <your namespace> get svc
NAME               TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
catalog-service    LoadBalancer   10.0.159.185   <pending>     80:30663/TCP   7m59s
customer-service   LoadBalancer   10.0.246.210   <pending>     80:31469/TCP   7m59s
front-end          LoadBalancer   10.0.159.101   <pending>     80:30284/TCP   7m58s
order-service      LoadBalancer   10.0.25.197    <pending>     80:32761/TCP   7m58s
```
1. Open the front-end in a browser
