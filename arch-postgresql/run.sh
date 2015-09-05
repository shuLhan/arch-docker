#!/bin/sh

PGDATA=$(pwd)/data

## create initial directory.
mkdir -p $PGDATA

## run docker using host data directory as postgresql dictionary files.
docker run --name db-pg --rm -v $PGDATA:/var/lib/postgres -it sulhan/arch-postgresql
