#!/bin/bash

echo "=========================================================="
echo "Stopping app on k8"
echo "=========================================================="

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders delete deploy frontend"
echo "----------------------------------------------------------"
kubectl -n dt-orders delete deploy frontend

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders delete deploy catalog"
echo "----------------------------------------------------------"
kubectl -n dt-orders delete deploy catalog

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders delete deploy customer"
echo "----------------------------------------------------------"
kubectl -n dt-orders delete deploy customer

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders delete deploy frontend"
echo "----------------------------------------------------------"
kubectl -n dt-orders delete deploy frontend

echo "----------------------------------------------------------"
echo "kubectl -n dt-orders get pods"
echo "----------------------------------------------------------"
kubectl -n dt-orders get pods