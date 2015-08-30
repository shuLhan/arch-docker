#!/bin/bash

## (1) set hostname.
## (2) set timezone to UTC.
## (3) set locale to en_GB.UTF-8.
## (4) generate locale.
## (5) set locale preferences.
## (6) stripping binaries.
## (7) remove unneeded files.
## (8) remove unneeded packages.

shopt -s extglob

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

## (4)
echo "==> generate locale."
/usr/bin/locale-gen

## (5)
echo "==> set locale preferences."
echo "LANG=en_GB.UTF-8"	> "$rootfs"/etc/locale.conf
echo "LC_MESSAGES=C.UTF-8" >> "$rootfs"/etc/locale.conf

## (6)
echo "==> striping binaries."
cd /

find usr/bin -type f \( -perm -0100 \) -print |
	xargs file |
	sed -n '/executable .*not stripped/s/: TAB .*//p' |
	xargs -rt strip --strip-unneeded

find usr/lib -type f \( -perm -0100 \) -print |
	xargs file |
	sed -n '/executable .*not stripped/s/: TAB .*//p' |
	xargs -rt strip --strip-unneeded

## (7)
echo "==> cleaning."

cd /
rm -r usr/share/perl5/*
rm -r usr/share/locale/*
rm -r usr/share/man/*

find usr/share/i18n/charmaps/ \! -name "UTF-8.gz" -delete
find usr/share/i18n/locales/ \! -name "en_GB" -delete

find usr/share/terminfo/ \
	\! -name ansi \
	\! -name cygwin \
	\! -name linux \
	\! -name screen-256color \
	\! -name vt100 \
	\! -name vt220 \
	\! -name xterm \
	-delete

rm -r usr/share/texinfo/*
rm -r usr/share/zoneinfo/*
rm -r usr/share/doc/*
rm -r usr/share/iana-etc/*
rm -r usr/share/info/*
rm -r usr/share/gtk-doc/*
rm -r usr/share/readline/*
rm -r usr/share/licenses/*

rm -r usr/include/*


## (8) remove unneeded packages.
pacman -Rs --noconfirm sed binutils db
pacman -Rdd --noconfirm perl

rm -r var/cache/pacman/pkg/*
rm -r var/log/*
