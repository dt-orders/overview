#!/bin/bash

echo "=========================================================="
echo "Stopping browser traffic on k8"
echo "=========================================================="

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders delete deploy browser-traffic"
echo "----------------------------------------------------------"
kubectl -n dt-orders delete deploy browser-traffic

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders get pods"
echo "----------------------------------------------------------"
kubectl -n dt-orders get pods