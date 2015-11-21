#!/bin/bash

#COMMANDS="pm2 start app.js"
WORKDIR=${WORKDIR:-"/srv/www"}
COMMANDS=${COMMANDS:-"pm2 --no-daemon start pm2.json"}
NODE_ENV=${NODE_ENV:-"production"}

cd $WORKDIR

npm install

eval $COMMANDS
