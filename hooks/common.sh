#!/bin/bash

#set -eux # -x for verbose logging to juju debug-log

# Set CONFIG constants
VERSION="1.4.2"
BASEURL="https://download.elasticsearch.org/logstash/logstash"
CHECKSUM="6e6be734392e8c7d6d55e23d0bd8d2b3"
WORKDIR="/opt"
BASEPATH="/opt/logstash"
CONFIG_DIR="${BASEPATH}/conf.d"
USER="logstash"
HOST=`unit-get private-address`

# Grab CONFIG variables
# Example :
#     USER=$(config-get user)
#     juju-log "Logstash User: ${USER}"

juju-log "Finished loading config variables"