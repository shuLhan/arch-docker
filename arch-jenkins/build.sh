#!/bin/sh

##
## Maintainer: Sulhan <ms@kilabit.info>
##
## Script to build nodejs image using `sulhan/arch-base` as base system.
##
## Usage
##	./build.sh [local|clean]
##
## If no parameter is given, it will sync and install package from container.
##
## local
##	update host db and packages first and copy the db and packages to
##	container.
##

PACKAGES="git jre8-openjdk jenkins"
IMAGE_NAME="sulhan/arch-jenkins"

echo ""
echo "==> building image for jenkins CI"
echo ""


clean() {
	rm -f *.db
	rm -f *.xz
	rm -f Dockerfile
	ln -s Dockerfile.online Dockerfile
	exit $1
}

docker_build() {
	docker build --force-rm -t $IMAGE_NAME .
	s=$?
	clean $s
}

if [[ $# = 0 ]]; then
	echo "==> Building docker image online ..."
	docker_build
fi

if [[ -z $1 || $1 != local ]]; then
	echo "Usage: ./build.sh [online]"
	exit 1
fi

if [[ $1 = "clean" ]]; then
	clean
fi

echo "==> Building docker image using local db and packages ..."

## always make sure local db and packages up to date.
sudo pacman -Syw --noconfirm --needed $PACKAGES
sudo pacman -Sc --noconfirm

cp /var/lib/pacman/sync/*.db ./

cp /var/cache/pacman/pkg/jre8-openjdk-headless-* \
	/var/cache/pacman/pkg/jre8-openjdk-8.* \
	/var/cache/pacman/pkg/nspr-* \
	/var/cache/pacman/pkg/sqlite-* \
	/var/cache/pacman/pkg/nss-* \
	/var/cache/pacman/pkg/glib2-* \
	/var/cache/pacman/pkg/cracklib-* \
	/var/cache/pacman/pkg/libtirpc-* \
	/var/cache/pacman/pkg/pambase-* \
	/var/cache/pacman/pkg/pam-* \
	/var/cache/pacman/pkg/shadow-* \
	/var/cache/pacman/pkg/lz4-* \
	/var/cache/pacman/pkg/libsystemd-* \
	/var/cache/pacman/pkg/util-linux-* \
	/var/cache/pacman/pkg/java-runtime-common-* \
	/var/cache/pacman/pkg/xcb-proto-* \
	/var/cache/pacman/pkg/xproto-* \
	/var/cache/pacman/pkg/libxdmcp-* \
	/var/cache/pacman/pkg/libxau-* \
	/var/cache/pacman/pkg/libxcb-* \
	/var/cache/pacman/pkg/kbproto-* \
	/var/cache/pacman/pkg/libx11-* \
	/var/cache/pacman/pkg/xextproto-* \
	/var/cache/pacman/pkg/libxext-* \
	/var/cache/pacman/pkg/libice-* \
	/var/cache/pacman/pkg/libsm-* \
	/var/cache/pacman/pkg/libxt-* \
	/var/cache/pacman/pkg/libxmu-* \
	/var/cache/pacman/pkg/xorg-xset-* \
	/var/cache/pacman/pkg/xdg-utils-* \
	/var/cache/pacman/pkg/hicolor-icon-theme-* \
\
	/var/cache/pacman/pkg/jenkins-* \
	/var/cache/pacman/pkg/libdbus-* \
	/var/cache/pacman/pkg/dbus-* \
	/var/cache/pacman/pkg/iptables-* \
	/var/cache/pacman/pkg/kbd-* \
	/var/cache/pacman/pkg/kmod-* \
	/var/cache/pacman/pkg/hwids-* \
	/var/cache/pacman/pkg/libseccomp-* \
	/var/cache/pacman/pkg/systemd-* \
	/var/cache/pacman/pkg/libusb-* \
	/var/cache/pacman/pkg/libpng-* \
	/var/cache/pacman/pkg/graphite-* \
	/var/cache/pacman/pkg/harfbuzz-* \
	/var/cache/pacman/pkg/freetype2-* \
	/var/cache/pacman/pkg/fontconfig-* \
	/var/cache/pacman/pkg/xorg-fonts-encodings-* \
	/var/cache/pacman/pkg/libfontenc-* \
	/var/cache/pacman/pkg/xorg-mkfontscale-* \
	/var/cache/pacman/pkg/xorg-mkfontdir-* \
	/var/cache/pacman/pkg/ttf-dejavu-* \
	/var/cache/pacman/pkg/libjpeg-turbo-* \
	/var/cache/pacman/pkg/libtiff-* \
	/var/cache/pacman/pkg/avahi-* \
	/var/cache/pacman/pkg/libcups-* \
\
	/var/cache/pacman/pkg/git-* \
	/var/cache/pacman/pkg/db-* \
	/var/cache/pacman/pkg/perl-5.* \
	/var/cache/pacman/pkg/perl-error-* \
	./

rm -f Dockerfile
ln -s Dockerfile.local Dockerfile
docker_build
