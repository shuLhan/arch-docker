#!/bin/bash

#COMMANDS="pm2 start app.js"
WORKDIR=${WORKDIR:-"/srv/www"}
COMMANDS=${COMMANDS:-"$WORKDIR/node_modules/.bin/sails lift"}
NODE_ENV=${NODE_ENV:-"development"}

cd $WORKDIR

if [ ! -d $WORKDIR/node_modules ]; then
	npm install
fi

eval $COMMANDS
