#!/bin/bash -x

cp ~/examples/load-generation/cartsloadgen/deploy/cartsloadgen-* ~/overview/demo_onbording/loadgen/.

DOMAIN=$KEPTN_DOMAIN

echo "changing to domain ${DOMAIN}"

SVCDOMAIN="svc.cluster.local"

for f in *.yaml; do sed -i "s|${SVCDOMAIN}|${DOMAIN}|g" "$f"; done
