#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "ERROR: script must be run as root or with sudo"
   exit 1
fi

# optionally pass in SCRIPT_HOME argument. For example: /home/azureuser
SCRIPT_HOME=$1
if [ -z $SCRIPT_HOME ]; then
   echo "Defaulting SCRIPT_HOME to /home/ubuntu"
   SCRIPT_HOME="/home/ubuntu"
fi

APP_SCRIPTS_PATH="$SCRIPT_HOME/overview/vm"

echo "*** Stopping Monolith ***"
sudo docker-compose -f "$APP_SCRIPTS_PATH/docker-compose-monolith.yaml" down

echo "***** Getting docker processes ***"
sudo docker ps

echo "*** Stopping Monolith Done. ***"