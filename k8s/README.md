# Overview 

This folder contains a few UNIX scripts and chart files to start and stop the dt-orders application and traffic generators.

**NOTE: These scripts only supports the microservices topology option**

# Prerequisites

1 . Create a Kubernetes cluster and configure `kubectl` to connect to it. 

2 . Have a Dynatrace tenant and install [Dynatrace OneAgent Operator](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/)  

# Deploy Application

1. Clone this repo 

    ```
    cd ~
    git clone https://github.com/dt-orders/overview.git
    ```

1. From the cloned repo, navigate to the virtual machine subfolder

    ```
    cd overview/k8s
    ```

1.  To create the `staging` namespace and to apply all the k8s YAML files, run this command

    ```
    ./start-app.sh
    ```

1.  Monitor pods.  

    ```
    kubectl -n dt-orders get pods

    # You should see this:
    NAME                        READY   STATUS    RESTARTS   AGE
    catalog-9bd57f66c-zw445     1/1     Running   0          6m48s
    customer-7bd5687fd7-mlr2d   1/1     Running   0          6m48s
    frontend-8699dd574f-vcwzn   1/1     Running   0          6m47s
    order-657b698d96-vhw5m      1/1     Running   0          6m47s
    ```

1.  Monitor services.  

    ```
    kubectl -n dt-orders get svc

    # This is example from AWS EKS
    NAME       TYPE           CLUSTER-IP       EXTERNAL-IP                       PORT(S)          AGE
    catalog    ClusterIP      10.100.27.48     <none>                            8080:30092/TCP   43m
    customer   ClusterIP      10.100.132.224   <none>                            8080:31785/TCP   38m
    frontend   LoadBalancer   10.100.247.102   xxx.eu-west-3.elb.amazonaws.com   80:30879/TCP     51m
    order      ClusterIP      10.100.104.247   <none>                            8080:32667/TCP   38m
    ```

1. Open the frontend URL in a browser using the EXTERNAL-IP

1. Another way to get informatin about the external URL for the frontend (and this may vary by the k8 installation you setup) is from these commands

    ```
    # Hostname
    echo http://$(kubectl -n dt-orders get service frontend -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")

    # IP
    echo http://$(kubectl -n dt-orders get service frontend -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
    ```

# Change image versions

Just edit the service `yaml` file `image` name and rerun `kubectl -n dt-orders apply <SERVICE YAML FILE>` and the monitor the new pod being created.

# Stop the application

This will not remove the namespace, it will just remove the k8s deployments that in turn stops the pods.

To so this, , run this command

```
./stop-app.sh
```

# Remove application

Easiest option is to just remove the namespace

```
kubectl delete ns dt-orders
```

Or you can just remove each deployment using the `stop` app and load unix scripts and then remove the namespace.
