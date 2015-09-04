#!/bin/bash

strip_bin() {
	find /usr/bin -type f \( -perm -0100 \) -print |
		xargs file |
		sed -n '/executable .*not stripped/s/: TAB .*//p' |
		xargs -rt strip --strip-unneeded
}

strip_lib() {
	find /usr/lib -type f \( -perm -0100 \) -print |
		xargs file |
		sed -n '/executable .*not stripped/s/: TAB .*//p' |
		xargs -rt strip --strip-unneeded
}

clean_common() {
	echo "==> cleaning ..."
	strip_bin
	strip_lib
	rm -rf /usr/include/*
	rm -rf /usr/share/doc/*
	rm -rf /usr/share/licenses/*
	rm -rf /usr/share/locale/*
	rm -rf /usr/share/man/*
	rm -rf /usr/share/info/*
	rm -rf /var/cache/pacman/pkg/*
	rm -rf /var/log/*
	rm -f /bootstrap.sh
}

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

## cleaning ...
clean_common
