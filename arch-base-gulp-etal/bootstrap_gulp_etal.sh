#!/bin/bash

echo "==> bootstraping gulp ..."

npm install -g grunt-cli --unsafe-perm && \
	npm install -g node-gyp --unsafe-perm && \
	npm install -g gulp && \
	npm install -g jshint && \
	npm install -g pm2 && \
	npm install -g phantomjs && \
	npm install -g coffee-script && \
	rm -r /root/.node-gyp

## cleaning ...
bootstrap_clean_nodejs
