#!/bin/bash
  
# optionally pass in SCRIPT_HOME argument. For example: /home/azureuser
SCRIPT_HOME=$1
if [ -z $SCRIPT_HOME ]; then
    echo "Defaulting SCRIPT_HOME to /home/ubuntu"
    SCRIPT_HOME="/home/ubuntu"
fi

APP_SCRIPTS_PATH="$SCRIPT_HOME/overview/vm"

LOGFILE='/tmp/start-monolith.log'
START_TIME="$(date)"

sudo rm $LOGFILE
touch $LOGFILE
sudo chmod 666 $LOGFILE

START_TIME="$(date)"
echo "***** Init Log ***" | tee -a $LOGFILE
echo "START_TIME       : $START_TIME " | tee -a $LOGFILE
echo "SCRIPT_HOME      : $SCRIPT_HOME" | tee -a $LOGFILE
echo "APP_SCRIPTS_PATH : $APP_SCRIPTS_PATH" | tee -a $LOGFILE

sudo $APP_SCRIPTS_PATH/stop-monolith.sh $SCRIPT_HOME | tee -a $LOGFILE

echo "***** Starting Monolith ***" | tee -a $LOGFILE
sudo docker-compose -f "$APP_SCRIPTS_PATH/docker-compose-monolith.yaml" up -d | tee -a $LOGFILE

echo "***** Sleeping 20 seconds to let application start ***" | tee -a $LOGFILE
sleep 20

echo "***** Getting docker processes ***" | tee -a $LOGFILE
sudo docker ps | tee -a $LOGFILE

END_TIME="$(date)"
echo ""
echo "START_TIME: $START_TIME     END_TIME: $END_TIME" | tee -a $LOGFILE
echo ""