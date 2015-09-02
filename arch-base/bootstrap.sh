#!/bin/bash

## (1) set hostname.
## (2) set timezone to UTC.
## (3) set locale to en_GB.UTF-8.
## (4) generate locale.
## (5) set locale preferences.
## (6) stripping binaries.
## (7) remove unneeded packages.
## (8) remove unneeded files.

shopt -s extglob

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
	rm -rf /usr/include/*
	rm -rf /usr/share/doc/*
	rm -rf /usr/share/licenses/*
	rm -rf /usr/share/locale/*
	rm -rf /usr/share/man/*
	rm -rf /usr/share/info/*
	rm -rf /var/cache/pacman/pkg/*
	rm -rf /var/log/*
}

## (0)
export LANG=C.UTF-8

## (1)
echo "==> set hostname."
echo "arch-base" > /etc/hostname

## (2)
echo "==> set timezone to UTC."
cp /usr/share/zoneinfo/UTC /etc/localtime

## (3)
echo "==> set locale to en_GB.UTF-8."
echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

## (4)
echo "==> generate locale."
/usr/bin/locale-gen

## (5)
echo "==> set locale preferences."
echo "LANG=en_GB.UTF-8"	> "$rootfs"/etc/locale.conf
echo "LC_MESSAGES=C" >> "$rootfs"/etc/locale.conf

## (6)
echo "==> striping binaries."
strip_bin
strip_lib

## (7)
pacman -Rs --noconfirm db
pacman -Rdd --noconfirm perl

## (8)
echo "==> cleaning."

find /usr/share/i18n/charmaps/ \! -name "UTF-8.gz" -delete
find /usr/share/i18n/locales/ \! -name "en_GB" -delete

find /usr/share/terminfo/ \
	\! -name ansi \
	\! -name cygwin \
	\! -name linux \
	\! -name screen-256color \
	\! -name vt100 \
	\! -name vt220 \
	\! -name xterm \
	-delete

rm -rf /usr/share/texinfo/*
rm -rf /usr/share/zoneinfo/*
rm -rf /usr/share/iana-etc/*
rm -rf /usr/share/gtk-doc/*
rm -rf /usr/share/readline/*

clean_common
