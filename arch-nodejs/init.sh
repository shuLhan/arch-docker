#!/bin/bash

export WORKDIR=${WORKDIR:-"/srv/www"}
export COMMANDS=${COMMANDS:-"npm start"}
export NODE_ENV=${NODE_ENV:-"development"}

cd $WORKDIR

if [ ! -d $WORKDIR/node_modules ]; then
	npm install
fi

eval $COMMANDS
