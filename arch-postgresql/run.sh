#!/bin/sh

## create initial directory.
mkdir -p data

## run docker using host data directory as postgresql dictionary files.
docker run --rm -v $(pwd)/data:/var/lib/postgres -it sulhan/arch-postgresql
