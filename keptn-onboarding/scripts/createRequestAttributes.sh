#!/bin/bash

# Usage:
# ./createTestStepCalculatedMetrics.sh CONTEXTLESS keptn-project simpleproject

source ~/keptn-in-a-box/resources/dynatrace/utils.sh

cd ~/keptn-in-a-box/resources/dynatrace

readCredsFromFile
printVariables

echo $DT_TENANT
echo $DT_API_TOKEN

if [[ -z "$DT_TENANT" || -z "$DT_API_TOKEN" ]]; then
  echo "DT_TENANT & DT_API_TOKEN MUST BE SET!!"
  exit 1
fi

echo "============================================================="
echo "About to create 2 Request Attributes on Dynatrace Tenant: $DT_TENANT!"
echo "============================================================="
echo "Usage: ./createRequestAttributes"
#read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key

####################################################################################################################
## createCalculatedTestMetric(METRICKEY, METRICNAME, BASEMETRIC, METRICUNIT)
####################################################################################################################
# Example: createCalculatedTestMetric "calc:service.teststepresponsetime", "Test Step Response Time", "RESPONSE_TIME", "MICRO_SECOND", "CONTEXTLESS", "keptn_project", "simpleproject")
# Full List of possible BASEMETRICS: CPU_TIME, DATABASE_CHILD_CALL_COUNT, DATABASE_CHILD_CALL_TIME, EXCEPTION_COUNT, FAILED_REQUEST_COUNT, FAILED_REQUEST_COUNT_CLIENT, FAILURE_RATE, FAILURE_RATE_CLIENT, HTTP_4XX_ERROR_COUNT, HTTP_4XX_ERROR_COUNT_CLIENT, HTTP_5XX_ERROR_COUNT, HTTP_5XX_ERROR_COUNT_CLIENT, IO_TIME, LOCK_TIME, NON_DATABASE_CHILD_CALL_COUNT, NON_DATABASE_CHILD_CALL_TIME, REQUEST_ATTRIBUTE, REQUEST_COUNT, RESPONSE_TIME, RESPONSE_TIME_CLIENT, SUCCESSFUL_REQUEST_COUNT, SUCCESSFUL_REQUEST_COUNT_CLIENT, TOTAL_PROCESSING_TIME, WAIT_TIME
# Possible METRICUNIT values: MILLI_SECOND, MICRO_SECOND, COUNT, PERCENT 
# Possible DIMENSION_AGGREGATE: AVERAGE, COUNT, MAX, MIN, OF_INTEREST_RATIO, OTHER_RATIO, SINGLE_VALUE, SUM
function createRequestAttribute() {
	ATTRIBUTENAME=$1
    PAYLOAD='{
  "name": "'$ATTRIBUTENAME'",
  "enabled": true,
  "dataType": "STRING",
  "dataSources": [
    {
      "enabled": true,
      "source": "REQUEST_HEADER",
      "valueProcessing": {
        "splitAt": "",
        "trim": false,
        "extractSubstring": {
          "position": "BETWEEN",
          "delimiter": "'$ATTRIBUTENAME'=",
          "endDelimiter": ";"
        }
      },
      "parameterName": "x-dynatrace-test",
      "capturingAndStorageLocation": "CAPTURE_AND_STORE_ON_CLIENT"
    }
  ],
  "normalization": "ORIGINAL",
  "aggregation": "FIRST",
  "confidential": false,
  "skipPersonalDataMasking": false
  }'

  echo ""
  echo "Creating Metric $METRICNAME($METRICNAME)"
  echo "POST https://$DT_TENANT/api/config/v1/cservice/requestAttributes"
  echo "$PAYLOAD"
  curl -X PUT \
          "https://$DT_TENANT/api/config/v1/service/requestAttributes" \
          -H 'accept: application/json; charset=utf-8' \
          -H "Authorization: Api-Token $DT_API_TOKEN" \
          -H 'Content-Type: application/json; charset=utf-8' \
          -d "$PAYLOAD" \
          -o curloutput.txt
  cat curloutput.txt
  echo ""
}



###########################################################################
# First we create TSN
###########################################################################
createRequestAttribute "TSN"

###########################################################################
# First we create LSN
###########################################################################
createRequestAttribute "LSN"

###########################################################################
# First we create LTN
###########################################################################
createRequestAttribute "LTN"
