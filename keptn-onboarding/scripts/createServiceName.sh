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
echo "About to create Service Naming Rule on Dynatrace Tenant: $DT_TENANT!"
echo "============================================================="
echo "Usage: ./createServiceName.sh"
#read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key

####################################################################################################################
## createRequestAttribute(ATTRIBUTENAME)
####################################################################################################################

function createServiceName() {
    PAYLOAD='{
  "type": "SERVICE",
  "nameFormat": "{ProcessGroup:KubernetesBasePodName}",
  "displayName": "DatabaseRename",
  "enabled": true,
  "rules": [
    {
      "key": {
        "attribute": "SERVICE_TYPE"
      },
      "comparisonInfo": {
        "type": "SERVICE_TYPE",
        "operator": "EQUALS",
        "value": "DATABASE_SERVICE",
        "negate": false
      }
    },
    {
      "key": {
        "attribute": "SERVICE_DATABASE_NAME"
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
}
'

  echo ""
  echo "Creating Metric $METRICNAME($METRICNAME)"
  echo "POST https://$DT_TENANT/api/config/v1/conditionalNaming/service"
  echo "$PAYLOAD"
  curl -X POST \
          "https://$DT_TENANT/api/config/v1/conditionalNaming/service" \
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
createServiceName

