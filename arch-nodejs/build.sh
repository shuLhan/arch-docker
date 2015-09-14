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

PACKAGES="git gcc make python2 nodejs npm"

clean() {
	rm -f *.db
	rm -f *.xz
	rm -f Dockerfile
	ln -s Dockerfile.online Dockerfile
	exit $1
}

docker_build() {
	docker build --force-rm -t sulhan/arch-nodejs .
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
## npm require python, make, gcc to rebuild packages.
sudo pacman -Syw --noconfirm --needed $PACKAGES

cp /var/lib/pacman/sync/*.db ./

## git.
cp /var/cache/pacman/pkg/db-5.* \
	/var/cache/pacman/pkg/perl-5.* \
	/var/cache/pacman/pkg/perl-error-* \
	/var/cache/pacman/pkg/git-2.* \
	./

## gcc.
cp /var/cache/pacman/pkg/libmpc-1.* \
	/var/cache/pacman/pkg/gcc-5.* \
	./

## python 2.
cp /var/cache/pacman/pkg/sqlite-3* \
	/var/cache/pacman/pkg/python2-2.* \
	./

## make.
cp /var/cache/pacman/pkg/tar-1.* \
	/var/cache/pacman/pkg/libtool-2.* \
	/var/cache/pacman/pkg/libunistring* \
	/var/cache/pacman/pkg/libatomic_ops* \
	/var/cache/pacman/pkg/gc-7.* \
	/var/cache/pacman/pkg/guile-2.* \
	/var/cache/pacman/pkg/make-4.* \
	./

## nodejs
cp /var/cache/pacman/pkg/icu-55.* \
	/var/cache/pacman/pkg/nodejs-0.12.* \
	/var/cache/pacman/pkg/npm-2.14.* \
	./

rm -f Dockerfile
ln -s Dockerfile.local Dockerfile
docker_build
