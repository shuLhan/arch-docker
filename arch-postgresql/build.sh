#!/bin/sh

##
## Maintainer: Sulhan <ms@kilabit.info>
##
## Script to build postgresql image using `sulhan/arch-base` as base system.
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

clean() {
	rm -f *.db
	rm -f *.xz
	rm -f Dockerfile
	ln -s Dockerfile.online Dockerfile
	exit $1
}

docker_build() {
	docker build --force-rm -t sulhan/arch-postgresql:latest .
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
sudo pacman -Syw --noconfirm postgresql

cp /var/lib/pacman/sync/*.db ./
cp /var/cache/pacman/pkg/cracklib* ./
cp /var/cache/pacman/pkg/libtirpc* ./
cp /var/cache/pacman/pkg/pam* ./
cp /var/cache/pacman/pkg/pambase* ./
cp /var/cache/pacman/pkg/libsystemd* ./
cp /var/cache/pacman/pkg/lz4* ./
cp /var/cache/pacman/pkg/shadow* ./
cp /var/cache/pacman/pkg/util-linux* ./
cp /var/cache/pacman/pkg/postgresql* ./
cp /var/cache/pacman/pkg/libxml2* ./

rm -f Dockerfile
ln -s Dockerfile.local Dockerfile
docker_build
