#!/bin/bash

install_util_linux() {
	pacman -Sy --noconfirm --needed util-linux
	return $?
}

install_postgresql() {
	pacman -S --noconfirm postgresql
	return $?
}

install_util_linux
while [ $? -ne 0 ]; do install_util_linux; done

install_postgresql
while [ $? -ne 0 ]; do install_postgresql; done

mkdir -p /var/lib/postgres/data
mkdir -p /run/postgresql

chown -R postgres:postgres /var/lib/postgres
chown -R postgres:postgres /run/postgresql

su - postgres -c "initdb --locale en_GB.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"

mv /pg_hba.conf /var/lib/postgres/data/
mv /postgresql.conf /var/lib/postgres/data/

chown -R postgres:postgres /var/lib/postgres
chown -R postgres:postgres /run/postgresql

rm /bootstrap.sh

rm -r /usr/include/*
rm -r /usr/share/doc/*
rm -r /usr/share/licenses/*
rm -r /usr/share/locale/*
rm -r /usr/share/man/*
rm -r /var/cache/pacman/pkg/*
rm -r /var/log/*
