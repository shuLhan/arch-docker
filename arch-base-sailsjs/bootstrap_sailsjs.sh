#!/bin/bash

npm install -g sails --unsafe-perm && \
	npm install -g pm2 --unsafe-perm && \
	npm install -g grunt && \
	rm -r /root/.node-gyp

## cleaning ...
bootstrap_clean_nodejs
