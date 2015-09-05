#!/bin/bash

JENKINS_DATA=/var/cache/jenkins

if [ -f $JENKINS_DATA/jenkins ]; then
	source $JENKINS_DATA/jenkins
else
	source /etc/conf.d/jenkins
fi

eval $JENKINS_COMMAND_LINE
