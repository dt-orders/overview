#!/bin/bash

echo "=========================================================="
echo "Starting load traffic on k8"
echo "=========================================================="

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders delete deploy load-traffic"
echo "----------------------------------------------------------"
kubectl -n dt-orders delete deploy load-traffic

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders get pods"
echo "----------------------------------------------------------"
kubectl -n dt-orders get pods