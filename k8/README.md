# Overview 

This folder contains the script and chart files to deploy the dt-orders application and traffic generators.

**NOTE: This only supports the microservices topology option**

# Prerequisites

1 . Create a Kubernetes cluster and configure `kubectl` to connect to it. 

2 . Have a Dynatrace tenant and install [Dynatrace OneAgent Operator](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/)  

# Deploy Application

There are a few scripts that can be used to start and stop the services
* Application - use the `start-app.sh` and `stop-app.sh`
* Browser traffic - use the `start-browser.sh` and `stop-browser.sh`
* Load traffic - use the `start-load.sh` and `stop-load.sh`

1 . Clone this repo and run the `start-app.sh` script

2 . Monitor pods.  You should see this:
```
kubectl -n dt-orders get pods
NAME                        READY   STATUS    RESTARTS   AGE
catalog-9bd57f66c-zw445     1/1     Running   0          6m48s
customer-7bd5687fd7-mlr2d   1/1     Running   0          6m48s
frontend-8699dd574f-vcwzn   1/1     Running   0          6m47s
order-657b698d96-vhw5m      1/1     Running   0          6m47s
```

3 . Monitor services.  This is example from AWS EKS
```
kubectl -n dt-orders get svc
NAME       TYPE           CLUSTER-IP       EXTERNAL-IP                       PORT(S)          AGE
catalog    ClusterIP      10.100.27.48     <none>                            8080:30092/TCP   43m
customer   ClusterIP      10.100.132.224   <none>                            8080:31785/TCP   38m
frontend   LoadBalancer   10.100.247.102   xxx.eu-west-3.elb.amazonaws.com   80:30879/TCP     51m
order      ClusterIP      10.100.104.247   <none>                            8080:32667/TCP   38m
```

4 . Get the external URL for the frontend

This may vary by the k8 installation you setup

```
# Hostname
echo http://$(kubectl -n dt-orders get service frontend -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")

# IP
echo http://$(kubectl -n dt-orders get service frontend -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
```

5 . Open the frontend URL in a browser

# Change image versions

Just edit the service `yaml` file `image` name and rerun `kubectl -n dt-orders apply <SERVICE YAML FILE>` and the monitor the new pod being created.

# Remove application

One option is to just remove the namespace

```
kubectl delete ns dt-orders
```

Or you can just remove each deployment using the `stop` app and load unix scripts and then remove the namespace.
