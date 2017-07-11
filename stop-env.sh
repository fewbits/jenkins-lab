#!/bin/bash
#
###############
# stop-env.sh #
###############
#
# Author: Eric G. S. Silva <eric.gssilva@gmail.com>
# Date: 2017-07-10
# Description:
#   This script will stop the whole environment used in this lab.
#
#################
# Configuration #
#################
#
#############
# Functions #
#############

function labStop() {
  echo "Stopping the Lab..."
  docker-compose down
}

########
# Stop #
########

# Stopping the Lab
labStop

#######
# End #
#######
