#!/bin/zsh

## Default environment if its not set
export HOSTNAME="arch-base-template"

#export LANG=C.UTF-8
#export BOOT_LANG=en_GB.UTF-8
#export TIMEZONE=UTC
#export LOCALES=(
#	"en_GB.UTF-8 UTF-8"
#	"en_US.UTF-8 UTF-8"
#)


## The size of rootfs in memory.
## Remember that we use tmpfs to speedup installation and copying.
## This is the default size, some bootstraping (i.e. nodejs) need more
## size (~900M).
#ROOTFS_SIZE=400M

## List of packages to be installed.
PKGS=(coreutils binutils findutils sed gzip file)
## List of packages to be installed after PKGS.
PKGS_ADD=()
## List of packages to be removed after creating chroot.
PKGS_REMOVED=(file gzip sed findutils less bzip2 pcre binutils perl db gdbm
	linux-api-headers)

## List of files that will be copied from current directory to rootfs
## The init.sh file is used to run the image.
## Format: source destination.
FILES+=("${PWD}/init.sh" "${ROOTFS}/")
FILES+=("${PWD}/bootstrap_rootfs.sh" "${ROOTFS}/")

## List of script that will be running on rootfs after package has been
## installed.
## The script path is relative to rootfs.
## Do not use the name bootstrap.sh because it was preserved for main script.
BOOTSTRAP_SCRIPTS=("/bootstrap_rootfs.sh")

##
## DOCKER RELATED
##
## The name of docker image.
IMAGE_NAME="username/imagename"

##
## List of arguments to be passed when creating images
## Example:
## IMAGE_ARGS=(-c="VOLUME /var/lib/postgres" -c="EXPOSE 5432" -c="CMD /init.sh")
##
IMAGE_ARGS=(-c="CMD /init.sh")
