#!/bin/sh

## Run any program here.
echo ">>> bootstraping ..."
mkdir -p /data/db
chown mongodb:daemon /data/db
