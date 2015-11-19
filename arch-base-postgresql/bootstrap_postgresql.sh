#!/bin/bash

echo "==> bootstraping postgresql ..."

mkdir -p /var/lib/postgres/data
mkdir -p /run/postgresql

chown -R postgres:postgres /var/lib/postgres
chown -R postgres:postgres /run/postgresql
