# Deployment using Kubernetes

1 . Create a Kubernetes cluster and configure kubectl to connect to it. 

2 . Have a Dynatrace tenant and install [Dynatrace OneAgent Operator](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/)  

3 . Grant [Dynatrace viewer role to k8 service accounts](https://www.dynatrace.com/support/help/shortlink/kubernetes-tagging#grant-viewer-role-to-service-accounts) with this command:

```
kubectl -n dt-orders create rolebinding default-view --clusterrole=view --serviceaccount=dt-orders:default
```

4 . Clone this repo and run these commands
```
# create the namespace
kubectl create ns dt-orders

# apply app chart files
kubectl -n dt-orders apply -f .

# apply just one for example:
kubectl -n dt-orders apply front-end.yaml
```

5 . Monitor pods.  You should see this:
```
kubectl -n dt-orders get pods
NAME                        READY   STATUS    RESTARTS   AGE
catalog-9bd57f66c-zw445     1/1     Running   0          6m48s
customer-7bd5687fd7-mlr2d   1/1     Running   0          6m48s
frontend-8699dd574f-vcwzn   1/1     Running   0          6m47s
order-657b698d96-vhw5m      1/1     Running   0          6m47s
```

6 . Monitor services.  This is example from AWS EKS
```
kubectl -n dt-orders get svc
NAME       TYPE           CLUSTER-IP       EXTERNAL-IP                       PORT(S)          AGE
catalog    ClusterIP      10.100.27.48     <none>                            8080:30092/TCP   43m
customer   ClusterIP      10.100.132.224   <none>                            8080:31785/TCP   38m
frontend   LoadBalancer   10.100.247.102   xxx.eu-west-3.elb.amazonaws.com   80:30879/TCP     51m
order      ClusterIP      10.100.104.247   <none>                            8080:32667/TCP   38m
```

7 . Get the external URL for the frontend

This may vary by the k8 installation you setup

```
# Hostname
echo http://$(kubectl -n dt-orders get service frontend -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")

# IP
echo http://$(kubectl -n dt-orders get service frontend -o jsonpath="{.status.loadBalancer.ingress[0].ip")
```

8 . Open the frontend URL in a browser

9 . To change image versions, just edit the service `yaml` file and run `kubectl -n dt-orders apply <SERVICE YAML FILE>` and the monitor the new pod being created.
