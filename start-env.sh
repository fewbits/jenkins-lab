#!/bin/bash
#
################
# start-env.sh #
################
#
# Author: Eric G. S. Silva <eric.gssilva@gmail.com>
# Date: 2017-07-10
# Description:
#   This script will try to start the whole environment needed to test the
#   following:
#   - Jenkins
#   - GitLab
#   - Pipeline As Code (Jenkinsfile), commited in GitLab
#
#################
# Configuration #
#################
#
#############
# Functions #
#############

function serviceStart() {
  serviceName=$1 # Name of Service to be started
  
  echo "Trying to start service '${serviceName}'... "
  sudo systemctl start ${serviceName} > /dev/null 2>&1  
  echo "We need to check service '${serviceName}' again"
  checkService ${serviceName}

}

function checkService() {
  serviceName=$1 # Name of Service to be checked

  echo -n "Checking state of service '${serviceName}'... "
  systemctl status ${serviceName} > /dev/null 2>&1
  serviceState=$?
  
  if [ $serviceState -eq 0 ]; then
    echo "[started]"
  else
    echo "[stopped]"
    serviceStart ${serviceName}
  fi

}

#########
# Start #
#########

# Validating: Services
checkService "docker.service"

# Starting environment
docker-compose up -d

#######
# End #
#######
















