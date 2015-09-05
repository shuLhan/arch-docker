#!/bin/bash

BUILDBOT_D=/srv/www

if [ -d ${BUILDBOT_D}/master ]; then
	buildbot start ${BUILDBOT_D}/master
fi

if [ -d ${BUILDBOT_D}/slave ]; then
	buildslave start ${BUILDBOT_D}/slave
fi
