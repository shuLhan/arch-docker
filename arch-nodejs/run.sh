#!/bin/sh

SRC=${SRC:-"$PWD/src"}
LINK=$([ "$LINK"x == "x" ] && echo "" || echo "--link $LINK")

export WORKDIR=${WORKDIR:-"/srv/www"}
export COMMANDS=${COMMANDS:-"npm start"}
export NODE_ENV=${NODE_ENV:-"development"}

## run docker using host data directory as postgresql dictionary files.
docker run -p 80:80 --rm --name nodejs \
	$LINK \
	-v $SRC:/srv/www \
	-e "WORKDIR=$WORKDIR" \
	-e "COMMANDS=$COMMANDS" \
	-e "NODE_ENV=$NODE_ENV" \
	-it sulhan/arch-nodejs \
	$@
