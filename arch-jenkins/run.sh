#!/bin/sh

JENKINS_DATA=$(pwd)/jenkins

docker run --rm -v $JENKINS_DATA:/var/cache/jenkins -p 8090:8090 -it sulhan/arch-jenkins "$@"
