#!/bin/sh

docker run --env-file=env.api --net=host --rm -v $PWD/npm:/root/.npm -v $PWD/src.api:/srv/www -it sulhan/arch-nodejs-0.12.9
