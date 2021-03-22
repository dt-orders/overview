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
## createRequestAttribute(ATTRIBUTENAME)
####################################################################################################################

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
      "capturingAndStorageLocation": "CAPTURE_AND_STORE_ON_SERVER"
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
  curl -X POST \
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
# Second we create LSN
###########################################################################
createRequestAttribute "LSN"

###########################################################################
# Third we create LTN
###########################################################################
createRequestAttribute "LTN"

###########################################################################
# Fourth we create LTN
###########################################################################
createRequestAttribute "SI"
