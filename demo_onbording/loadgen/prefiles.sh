#!/bin/bash -x

cp ~/examples/load-generation/cartsloadgen/deploy/cartsloadgen-* ~/overview/demo_onbording/loadgen/.

DOMAIN=$KEPTN_DOMAIN

echo "changing to domain ${DOMAIN}"
