#!/bin/bash

KEPTN_PROJECT=keptnorders
KEPTN_DOMAIN=$(kubectl get cm keptn-domain -n keptn -ojsonpath={.data.app_domain})
     
echo ""
echo "--------------------------------------------------------------------------"
echo "Keptn Bridge:"
echo "--------------------------------------------------------------------------"
echo "https://bridge.keptn.$KEPTN_DOMAIN/#/"
echo "--------------------------------------------------------------------------"
echo ""
echo "--------------------------------------------------------------------------"
echo "Orders Application:"
echo "--------------------------------------------------------------------------"
echo "http://front-end.$KEPTN_PROJECT-staging.$KEPTN_DOMAIN/"
echo "http://front-end.$KEPTN_PROJECT-production.$KEPTN_DOMAIN/"
echo "--------------------------------------------------------------------------"
echo ""
echo "--------------------------------------------------------------------------"
echo "kubectl get pods -n $KEPTN_PROJECT-staging"
kubectl get pods -n $KEPTN_PROJECT-staging
echo "--------------------------------------------------------------------------"
echo "kubectl get pods -n $KEPTN_PROJECT-production"
kubectl get pods -n $KEPTN_PROJECT-production
