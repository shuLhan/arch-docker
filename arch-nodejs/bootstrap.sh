#!/bin/bash

PACKAGES="git gcc make python2 nodejs npm"

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
	rm -rf /usr/share/doc/*
	rm -rf /usr/share/licenses/*
	rm -rf /usr/share/locale/*
	rm -rf /usr/share/man/*
	rm -rf /usr/share/info/*
	rm -rf /var/cache/pacman/pkg/*
	rm -rf /var/log/*
	rm -f /bootstrap.sh
}

do_install() {
	pacman -S --noconfirm $PACKAGES
	return $?
}

do_install
while [ $? -ne 0 ]; do do_install; done

## cleaning ...
rm -r /usr/share/icu/*
rm -r /usr/lib/node_modules/npm/doc/*
rm -r /usr/lib/node_modules/npm/html/doc/*
rm -r /usr/lib/node_modules/npm/man/*

clean_common
