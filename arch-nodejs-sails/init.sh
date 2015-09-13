#!/bin/bash

WORKDIR=/srv/www

cd $WORKDIR

if [ ! -d $WORKDIR/node_modules ]; then
	npm install
fi

#pm2 start app.js
sails lift
