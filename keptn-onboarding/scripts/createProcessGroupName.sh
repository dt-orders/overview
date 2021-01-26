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
echo "About to create Process Group Naming Rule on Dynatrace Tenant: $DT_TENANT!"
echo "============================================================="
echo "Usage: ./createProcessGroupName.sh"
#read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key

####################################################################################################################
## createRequestAttribute(ATTRIBUTENAME)
####################################################################################################################

function createProcessGroupName() {
    PAYLOAD='{
  "type": "PROCESS_GROUP",
  "nameFormat": "{ProcessGroup:Environment:keptn_project}.{ProcessGroup:Environment:keptn_stage}.{ProcessGroup:Environment:keptn_service} [{ProcessGroup:Environment:keptn_deployment}]",
  "displayName": "Keptn Processgroup Naming",
  "enabled": true,
  "rules": [
    {
      "key": {
        "attribute": "PROCESS_GROUP_CUSTOM_METADATA",
        "dynamicKey": {
          "source": "ENVIRONMENT",
          "key": "keptn_deployment"
        },
        "type": "PROCESS_CUSTOM_METADATA_KEY"
      },
      "comparisonInfo": {
        "type": "STRING",
        "operator": "EXISTS",
        "value": null,
        "negate": false,
        "caseSensitive": null
      }
    }
  ]
}'

  echo ""
  echo "Creating Metric $METRICNAME($METRICNAME)"
  echo "POST https://$DT_TENANT/api/config/v1/conditionalNaming/processGroup"
  echo "$PAYLOAD"
  curl -X POST \
          "https://$DT_TENANT/api/config/v1/conditionalNaming/processGroup" \
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
createProcessGroupName

