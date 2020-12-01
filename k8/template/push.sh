#!/bin/bash

FRONT_END_FILE_TEMPLATE_FILE="/k8/template/frontend.yaml"
CATALOG_FILE_TEMPLATE_FILE="/k8/template/catalog-service.yaml"
ORDER_FILE_TEMPLATE_FILE="/k8/template/order-service.yaml"
CUSTOMER_FILE_TEMPLATE_FILE="/k8/template/customer-service.yaml"         
        

FRONT_END_FILE="/k8/lab2/frontend.yaml"
CATALOG_FILE="/k8/lab2/catalog-service.yaml"
ORDER_FILE="/k8/lab2/order-service.yaml"
CUSTOMER_FILE="/k8/lab2/customer-service.yaml"

frontendimage="dtdemos/dt-orders-frontend:"$1
orderserviceimage="dtdemos/dt-orders-order-service:"$2
customerserviceimage="dtdemos/dt-orders-customer-service:"$3
catalogserviceimage="dtdemos/dt-orders-catalog-service:"$4

cp -f * /home/ubuntu/overview/k8/lab2/.

cd /home/ubuntu/overview/k8/lab2

sed -i "s|REPLACE-FRONTEND-IMAGE|$frontendimage|g" /home/ubuntu/overview/$FRONT_END_FILE
sed -i "s|REPLACE-ORDER-IMAGE|$orderserviceimage|g" /home/ubuntu/overview/$ORDER_FILE
sed -i "s|REPLACE-CUSTOMER-IMAGE|$customerserviceimage|g" /home/ubuntu/overview/$CUSTOMER_FILE
sed -i "s|REPLACE-CATALOG-IMAGE|$catalogserviceimage|g" /home/ubuntu/overview/$CATALOG_FILE

cat /home/ubuntu/overview/k8/lab2/frontend.yaml

# apply app cart files
kubectl -n dt-orders apply -f .
