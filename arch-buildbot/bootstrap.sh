#!/bin/bash

PACKAGES="buildbot buildbot-slave"

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

do_fix_python() {
	easy_install-2.7 sqlalchemy==0.7.10 sqlalchemy-migrate==0.7.2
	return $?
}

do_install
while [ $? -ne 0 ]; do do_install; done

do_fix_python
while [ $? -ne 0 ]; do do_fix_python; done

## cleaning ...
clean_common
