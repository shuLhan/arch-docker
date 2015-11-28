#!/bin/bash

export LANG=C.UTF-8
export HOSTNAME="arch-base"
export BOOT_LANG=en_GB.UTF-8
export PKG_REMOVED=()

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

bootstrap_clean_common() {
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
	rm -f /*.sh
}

bootstrap_hostname() {
	echo "==> set hostname ..."
	echo ${HOSTNAME} > /etc/hostname
}

bootstrap_timezone() {
	echo "==> set timezone to UTC ..."
	cp /usr/share/zoneinfo/UTC /etc/localtime
}

bootstrap_locales() {
	echo "==> set locales ..."
	echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

	echo "==> generate locale ..."
	/usr/bin/locale-gen

	echo "==> set locale preferences ..."
	echo "LANG=${BOOT_LANG}"	>  "$rootfs"/etc/locale.conf
	echo "LC_MESSAGES=C"		>> "$rootfs"/etc/locale.conf
}

bootstrap_remove_packages() {
	echo "==> remove unneeded packages ..."
	for pkg in ${PKGS_REMOVED[@]}; do
		echo "    removing $pkg"
		pacman -Rdd --noconfirm $pkg
	done
}

bootstrap_clean_base() {
	echo "==> cleaning base ..."
	## Remove all charmaps except UTF-8.
	find /usr/share/i18n/charmaps/ \! -name "UTF-8.gz" -delete
	## Remove all locales except en_GB and en_US.
	find /usr/share/i18n/locales/ \! -name "en_GB" \! -name "en_US" -delete
	## Remove all terminfo excetp ansi,cygwin,linux,screen-256color,vt100,vt220,
	## and xterm.
	find /usr/share/terminfo/ \
		\! -name ansi \
		\! -name cygwin \
		\! -name linux \
		\! -name screen-256color \
		\! -name vt100 \
		\! -name vt220 \
		\! -name xterm \
		-delete
	## Remove all unneeded doc.
	rm -rf /usr/share/texinfo/*
	rm -rf /usr/share/zoneinfo/*
	rm -rf /usr/share/iana-etc/*
	rm -rf /usr/share/gtk-doc/*
	rm -rf /usr/share/readline/*
}

bootstrap_clean_nodejs() {
	echo "==> cleaning nodejs ..."
	rm -r /usr/share/icu/*
	rm -r /usr/lib/node_modules/npm/doc/*
	rm -r /usr/lib/node_modules/npm/html/doc/*
	rm -r /usr/lib/node_modules/npm/man/*
	rm -rf /usr/lib/python2.7/test
	rm -rf /usr/share/perl5

	find /usr/lib/node_modules -name man -type d -exec rm -rf '{}' \;
	find /usr/lib/node_modules -name doc -type d -exec rm -rf '{}' \;
	find /usr/lib/node_modules -name html -type d -exec rm -rf '{}' \;
}
