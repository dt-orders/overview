#!/bin/bash

kubectl -n keptn set image deployment/jmeter-service jmeter-service=keptn/jmeter-service:0.7.3-patch1 --record

