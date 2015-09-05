#!/bin/bash

PACKAGES_DEPS="git jre8-openjdk"
PACKAGES="jenkins"

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
	rm -rf /usr/share/gtk-doc/*
	rm -rf /usr/share/git-gui/*
	rm -rf /usr/share/hwdata/*
	rm -rf /usr/share/icons/*
	rm -rf /usr/share/git/*
	rm -rf /usr/share/X11/*
	rm -rf /usr/share/kbd/*
	rm -rf /usr/share/perl5/*

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
	pacman -S --noconfirm $PACKAGES_DEPS
	pacman -S --noconfirm $PACKAGES
	return $?
}

do_install
while [ $? -ne 0 ]; do do_install; done

## cleaning ...
clean_common
