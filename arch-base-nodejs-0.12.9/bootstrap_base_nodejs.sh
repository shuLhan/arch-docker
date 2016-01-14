#!/bin/sh

NVM_DIR=/root/.nvm
NODE_VERSION=v0.12.9

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

## create symlink to python
cd /usr/bin && ln -s python2 python
cd

nvm install ${NODE_VERSION}
nvm alias default ${NODE_VERSION}
nvm use default

## Set path
export PATH=$PATH:`npm bin -g`

echo ">>> installing pm2"
npm install -g pm2

echo ">>> installing grunt-cli"
npm install -g grunt-cli

echo ">>> installing gulp"
npm install -g gulp

echo ">>> installing bower"
npm install -g bower

echo ">>> installing sails"
npm install -g sails --ignore-scripts

npm cache clean
