#!/bin/sh

SRC=$(pwd)/src

## run docker using host data directory as postgresql dictionary files.
docker run -p 80:80 --rm --name sails --link db-pg:db -v $SRC:/srv/www -it sulhan/arch-nodejs-sails $@
