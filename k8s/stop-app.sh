#!/bin/bash

echo "=========================================================="
echo "Stopping app on k8"
echo "=========================================================="

echo "----------------------------------------------------------"
echo "kubectl -n staging delete deploy browser-traffic"
echo "----------------------------------------------------------"
kubectl -n staging delete deploy browser-traffic

echo "----------------------------------------------------------"
echo "kubectl -n staging delete deploy load-traffic"
echo "----------------------------------------------------------"
kubectl -n staging delete deploy load-traffic

echo "----------------------------------------------------------"
echo "kubectl -n staging delete deploy frontend"
echo "----------------------------------------------------------"
kubectl -n staging delete deploy frontend

echo "----------------------------------------------------------"
echo "kubectl -n staging delete deploy catalog"
echo "----------------------------------------------------------"
kubectl -n staging delete deploy catalog

echo "----------------------------------------------------------"
echo "kubectl -n staging delete deploy customer"
echo "----------------------------------------------------------"
kubectl -n staging delete deploy customer

echo "----------------------------------------------------------"
echo "kubectl -n staging delete deploy order"
echo "----------------------------------------------------------"
kubectl -n staging delete deploy order

sleep 10

echo "----------------------------------------------------------"
echo "kubectl -n staging get pods"
echo "----------------------------------------------------------"
kubectl -n staging get pods