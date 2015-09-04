#!/bin/bash

if [ ! -f /var/lib/postgres/data/pg_hba.conf ]; then
	chown -R postgres:postgres /var/lib/postgres

	su - postgres -c "initdb --locale en_GB.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"

	su - postgres -c cat <<EOF > /var/lib/postgres/data/pg_hba.conf
## "local" is for Unix domain socket connections only
local   all             all                                     trust
## IPv4 local connections:
host    all             all             127.0.0.1/32            trust
## IPv6 local connections:
host    all             all             ::1/128                 trust
## Allow docker host.
host    all             all             172.17.42.0/16          trust
## Allow other docker's containers.
host    all             all             172.17.0.0/16           trust
EOF

	su - postgres -c cat <<EOF > /var/lib/postgres/data/postgresql.conf
listen_addresses = '*'
max_connections = 100
shared_buffers = 128MB
dynamic_shared_memory_type = posix
datestyle = 'iso, dmy'
lc_messages = 'en_GB.UTF-8'
lc_monetary = 'en_GB.UTF-8'
lc_numeric = 'en_GB.UTF-8'
lc_time = 'en_GB.UTF-8'
default_text_search_config = 'pg_catalog.english'
EOF
fi

su - postgres -c "postgres -D '/var/lib/postgres/data'"
