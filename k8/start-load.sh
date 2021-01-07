#!/bin/bash

clear

NUM_LOOPS=$1
if [ -z "$NUM_LOOPS" ]
then
    NUM_LOOPS=100000
fi

TEST_DEBUG=$2
if [ -z "$TEST_DEBUG" ]
then
    TEST_DEBUG=false
fi

SERVER_URL=$3
if [ -z "$SERVER_URL" ]
then
    SERVER_URL="frontend"
fi

echo "=================================================="
echo "Starting load traffic"
echo "SERVER_URL : $SERVER_URL"
echo "NUM_LOOPS  : $NUM_LOOPS"
echo "TEST_DEBUG : $TEST_DEBUG"
echo "=================================================="
rm load-traffic.yaml
cp load-traffic.template load-traffic.yaml

sed -i 's|REPLACE_SERVER_URL|'$SERVER_URL'|g' load-traffic.yaml
sed -i 's|REPLACE_NUM_LOOPS|'$NUM_LOOPS'|g' load-traffic.yaml
sed -i 's|REPLACE_TEST_DEBUG|'$TEST_DEBUG'|g' load-traffic.yaml

echo "=================================================="
echo "kubectl -n dt-orders apply -f load-traffic.yaml"
echo "=================================================="
kubectl -n dt-orders apply -f load-traffic.yaml

echo "=================================================="
echo "kubectl -n dt-orders get pods"
echo "=================================================="
kubectl -n dt-orders get pods