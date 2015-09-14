#!/bin/sh

SRC=${SRC:-"$PWD/src"}
LINK=$([ "$LINK"x == "x" ] && echo "" || echo "--link $LINK")

## run docker using host data directory as postgresql dictionary files.
docker run -p 80:80 --rm --name sails $LINK -v $SRC:/srv/www \
	-it sulhan/arch-nodejs-sails \
	$@
