#!/bin/bash

export WORKDIR=${WORKDIR:-"/srv/www"}
export COMMANDS=${COMMANDS:-"npm start"}
export NODE_ENV=${NODE_ENV:-"production"}

echo "WORKDIR=$WORKDIR"
echo "COMMANDS=$COMMANDS"
echo "NODE_ENV=$NODE_ENV"

cd $WORKDIR

npm install

eval $COMMANDS
