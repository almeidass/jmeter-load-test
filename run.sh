#!/bin/bash

NAME="jmeter"
JMETER_VERSION=${JMETER_VERSION:-"5.4.1"}
IMAGE="almeidass/jmeter:${JMETER_VERSION}"

docker run --rm --name ${NAME} -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} $@
