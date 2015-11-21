#!/bin/zsh

docker run --env-file=env --net=host --rm \
	-v $PWD/npm:/root/.npm \
	-v $PWD/src:/srv/www \
	-it sulhan/arch-nodejs-sails
