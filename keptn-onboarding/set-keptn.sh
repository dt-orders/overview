#!/bin/bash

    keptn add-resource --project=keptnorders --service=frontend --stage=staging --resource=frontend/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
    keptn add-resource --project=keptnorders --service=frontend --stage=staging --resource=frontend/jmeter/load.jmx --resourceUri=jmeter/load.jmx

    keptn add-resource --project=keptnorders --service=customer --stage=staging --resource=customer/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
    keptn add-resource --project=keptnorders --service=customer --stage=staging --resource=customer/jmeter/load.jmx --resourceUri=jmeter/load.jmx

    keptn add-resource --project=keptnorders --service=catalog --stage=staging --resource=catalog/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
    keptn add-resource --project=keptnorders --service=catalog --stage=staging --resource=catalog/jmeter/load.jmx --resourceUri=jmeter/load.jmx

    keptn add-resource --project=keptnorders --service=order --stage=staging --resource=order/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
    keptn add-resource --project=keptnorders --service=order --stage=staging --resource=order/jmeter/load.jmx --resourceUri=jmeter/load.jmx
    
    