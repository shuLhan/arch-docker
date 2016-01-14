#!/bin/bash

WORKDIR=${WORKDIR:-"/srv/www"}
COMMANDS=${COMMANDS:-"pm2 --no-daemon start /pm2.json"}
NODE_ENV=${NODE_ENV:-"development"}

NVM_DIR=/root/.nvm
. "$NVM_DIR/nvm.sh"
nvm use node

cd $WORKDIR

npm install

eval $COMMANDS
