# Overview

This will setup the keptn-orders demo app in Kubernetes without Istio or Keptn or using docker-compose.

# docker-compose

1. Have a host with Docker and docker-compose installed on it

1. Have a Dynatrace tenant and Dynatrace OneAgent Operator on host running docker-compose

1. Clone this repo and run these commands
```
docker-compose up -d
```

1. Check that containers are running
```
docker-compose ps


```

1. Open the front-end in a browser for the app

1. Stop all the containers
```
docker-compose down
```

# Kubernetes

1. Create a Kubernetes cluster and configure kubectl to connect to it. 

1. Have a Dynatrace tenant and install Dynatrace OneAgent Operator.  

1. Clone this repo and run these commands
```
kubectl create ns keptn-orders

# apply app chart files
kubectl -n keptn-orders apply -R -f .

# apply just one for example:
kubectl -n keptn-orders apply front-end.yaml
```

1. Monitor pods.  You should see this:
```
kubectl -n keptn-orders get pods
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

1. Open the front-end EXTERNAL-IP in a browser
