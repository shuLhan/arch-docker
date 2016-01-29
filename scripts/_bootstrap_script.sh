#!/bin/bash

export LANG=C.UTF-8
export HOSTNAME="arch-base"
export BOOT_LANG=en_GB.UTF-8
export TIMEZONE=UTC
export PKG_REMOVED=()
declare -a LOCALES=(
	"en_GB.UTF-8 UTF-8"
	"en_US.UTF-8 UTF-8"
)

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
	echo ""
	echo "==> cleaning ..."
	echo ">>> stripping binaries"
	strip_bin
	echo ">>> stripping libraries"
	strip_lib

	rm -rf /usr/share/doc/*
	rm -rf /usr/share/licenses/*
	rm -rf /usr/share/locale/*
	rm -rf /usr/share/man/*
	rm -rf /usr/share/info/*
	rm -rf /var/cache/pacman/pkg/*
	rm -rf /var/log/*
	rm -f /vars.sh
}

bootstrap_hostname() {
	echo ""
	echo "==> set hostname to '${HOSTNAME}' ..."
	echo ${HOSTNAME} > /etc/hostname
}

bootstrap_timezone() {
	echo ""
	echo "==> set timezone to '${TIMEZONE}'..."
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
}

bootstrap_locales() {
	echo ""
	echo "==> set locales ..."

	echo "#" > /etc/locale.gen
	for i in "${LOCALES[@]}"; do
		echo "$i" >> /etc/locale.gen
	done

	echo "==> generate locale ..."
	/usr/bin/locale-gen

	echo "==> set locale preferences ..."
	echo "LANG=${BOOT_LANG}"	>  "$rootfs"/etc/locale.conf
	echo "LC_MESSAGES=C"		>> "$rootfs"/etc/locale.conf
}

bootstrap_remove_packages() {
	echo ""
	echo "==> remove unneeded packages ..."
	for pkg in ${PKGS_REMOVED[@]}; do
		echo "    removing $pkg"
		pacman -Rdd --noconfirm $pkg
	done
}

bootstrap_clean_base() {
	echo ""
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

	rm -r /usr/share/icu/*
	rm -rf /usr/lib/python2.7/test
	rm -rf /usr/share/perl5

	echo "==> cleaning nodejs ..."
	rm -r /usr/lib/node_modules/npm/doc/*
	rm -r /usr/lib/node_modules/npm/html/doc/*
	rm -r /usr/lib/node_modules/npm/man/*
	find /usr/lib/node_modules -name man -type d -exec rm -rf '{}' \;
	find /usr/lib/node_modules -name doc -type d -exec rm -rf '{}' \;
	find /usr/lib/node_modules -name html -type d -exec rm -rf '{}' \;
}

bootstrap_clean_myself() {
	echo ""
	echo "==> bootstrap: cleaning my self"
	rm -f /_bootstrap_script.sh
	rm -f /_bootstrap_post.sh
	rm -f /run_bootstrap.sh
}

bootstrap_post_main() {
	echo "==> post bootstrap ..."
	bootstrap_hostname
	bootstrap_timezone
	bootstrap_locales
	bootstrap_clean_common
	bootstrap_clean_base
	bootstrap_clean_myself
}
