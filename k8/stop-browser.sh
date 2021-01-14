#!/bin/bash

clear

echo "=========================================================="
echo "kubectl -n dt-orders delete deploy browser-traffic"
echo "=========================================================="
kubectl -n dt-orders delete deploy browser-traffic

echo "=========================================================="
echo "kubectl -n dt-orders get pods"
echo "=========================================================="
kubectl -n dt-orders get pods