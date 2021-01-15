#!/bin/bash

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

THEHOST=$3
if [ -z "$THEHOST" ]
then
    THEHOST="frontend"
fi

echo "=================================================="
echo "Starting load traffic on k8"
echo "HOSTNAME   : $THEHOST"
echo "NUM_LOOPS  : $NUM_LOOPS"
echo "TEST_DEBUG : $TEST_DEBUG"
echo "=================================================="
rm load-traffic.yaml
cp load-traffic.template load-traffic.yaml

sed -i 's|REPLACE_HOSTNAME|'$THEHOST'|g' load-traffic.yaml
sed -i 's|REPLACE_NUM_LOOPS|'$NUM_LOOPS'|g' load-traffic.yaml
sed -i 's|REPLACE_TEST_DEBUG|'$TEST_DEBUG'|g' load-traffic.yaml

echo "--------------------------------------------------"
echo "kubectl -n dt-orders apply -f load-traffic.yaml"
echo "--------------------------------------------------"
kubectl -n dt-orders apply -f load-traffic.yaml

echo "--------------------------------------------------"
echo "kubectl -n dt-orders get pods"
echo "--------------------------------------------------"
kubectl -n dt-orders get pods