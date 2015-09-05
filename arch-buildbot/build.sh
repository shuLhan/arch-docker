#!/bin/sh

##
## Maintainer: Sulhan <ms@kilabit.info>
##
## Script to build buildbot (master and slave) image using `sulhan/arch-base`
## as base system.
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

PACKAGES="buildbot buildbot-slave"
IMAGE_NAME="sulhan/arch-buildbot"

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
## npm require python, make, gcc to rebuild packages.
sudo pacman -Syw --noconfirm --needed $PACKAGES
sudo pacman -Sc --noconfirm

cp /var/lib/pacman/sync/*.db ./

## buildbot
cp	/var/cache/pacman/pkg/python2-*.* \
	/var/cache/pacman/pkg/buildbot* ./
	./

rm -f Dockerfile
ln -s Dockerfile.local Dockerfile
docker_build
