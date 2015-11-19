#!/bin/bash

. /bootstrap_postgresql.sh

if [ ! -f /var/lib/postgres/data/pg_hba.conf ]; then
	su - postgres -c "initdb --locale en_GB.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
	su - postgres -c "cp /pg_hba.conf /var/lib/postgres/data/pg_hba.conf"
	su - postgres -c "cp /postgresql.conf /var/lib/postgres/data/postgresql.conf"
fi

su - postgres -c "postgres -D '/var/lib/postgres/data'"
