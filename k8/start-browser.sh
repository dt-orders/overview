#!/bin/bash

clear

SCRIPT_NUM_LOOPS=$1
if [ -z "$SCRIPT_NUM_LOOPS" ]
then
    SCRIPT_NUM_LOOPS=15000
fi

APP_URL=$2
if [ -z "$APP_URL" ]
then
    APP_URL="http://frontend"
fi

echo "=================================================="
echo "Starting browser traffic"
echo "APP_URL          : $APP_URL"
echo "SCRIPT_NUM_LOOPS : $SCRIPT_NUM_LOOPS"
echo "=================================================="
rm browser-traffic.yaml
cp browser-traffic.template browser-traffic.yaml

sed -i 's|REPLACE_APP_URL|'$APP_URL'|g' browser-traffic.yaml
sed -i 's|REPLACE_SCRIPT_NUM_LOOPS|'$SCRIPT_NUM_LOOPS'|g' browser-traffic.yaml

echo "=================================================="
echo "kubectl -n dt-orders apply -f browser-traffic.yaml"
echo "=================================================="
kubectl -n dt-orders apply -f browser-traffic.yaml

echo "=================================================="
echo "kubectl -n dt-orders get pods"
echo "=================================================="
kubectl -n dt-orders get pods