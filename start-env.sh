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

function checkProxy() {
  echo -n "Checking state of system proxy... "
  
  if [ ${http_proxy} ]; then
    echo "[enabled]"
  else
    echo "[disabled]"
  fi
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

function jenkinsPluginInstall() {
  pluginName=$1 # Name of Plugin to be installed
  
  echo "Installing Jenkins Plugin '${pluginName}'..."
  docker-compose exec jenkins bash -c "/usr/bin/java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s http://127.0.0.1:8080/ install-plugin ${pluginName}"

}

function jenkinsRestartSafe() {

  echo "Restarting Jenkins..."
  docker-compose exec jenkins bash -c '/usr/bin/java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s http://127.0.0.1:8080/ safe-restart'

  jenkinsWaitUp
}

function jenkinsWaitUp() {

  echo -n "Waiting until Jenkins becomes fully up..."
  docker-compose logs --tail=10 | grep "INFO: Jenkins is fully up and running" > /dev/null 2>&1
  jenkinsLogRC=$?
  
  until [ $jenkinsLogRC -eq 0 ]
  do
    echo -n "."
    sleep 2
    docker-compose logs --tail=10 | grep "INFO: Jenkins is fully up and running" > /dev/null 2>&1
    jenkinsLogRC=$?
  done
  
  echo " [ok]"
}

function labConfigure() {
  echo "Configuring the Lab..."
  jenkinsPluginInstall github
  jenkinsPluginInstall pipeline-multibranch-defaults
  jenkinsPluginInstall workflow-aggregator
  jenkinsRestartSafe
}

function labStart() {
  echo "Starting the Lab..."
  docker-compose up -d

  jenkinsWaitUp
}

function serviceStart() {
  serviceName=$1 # Name of Service to be started
  
  echo "Trying to start service '${serviceName}'... "
  sudo systemctl start ${serviceName} > /dev/null 2>&1  
  echo "We need to check service '${serviceName}' again"
  checkService ${serviceName}

}

#########
# Start #
#########

# Validations
checkProxy
checkService "docker.service"

# Starting the Lab
labStart

# Configuring the Lab
labConfigure

#######
# End #
#######
