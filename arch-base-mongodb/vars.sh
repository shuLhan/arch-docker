#!/bin/zsh

## Get current directory.
THISD=${0:a:h}

## The name of docker image.
IMAGE_NAME="sulhan/arch-mongodb"

##
## List of arguments to be passed when creating images
## Example:
## IMAGE_ARGS=(-c="VOLUME /var/lib/postgres" -c="EXPOSE 5432")
##
IMAGE_ARGS=(-c="VOLUME /data/db" -c="EXPOSE 27017" -c="CMD /init.sh")

## The size of rootfs in memory.
## Remember that we use tmpfs to speedup installation and copying.
## This is the default size, some bootstraping (i.e. nodejs) need more
## size (~900M).
ROOTFS_SIZE=600M

## List of packages to be installed.
PKGS=(binutils coreutils file findutils gzip sed shadow)

## List of packages to be installed after PKGS.
PKGS_ADD=(mongodb)

## List of packages to be removed after creating chroot.
PKGS_REMOVED=(binutils bzip2 db file findutils gdbm gzip less linux-api-header
	pcre perl sed)

## List of files that will be copied from current directory to rootfs
## The init.sh file is used to run the image.
## Format: source destination.
FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/bootstrap_rootfs.sh" "${ROOTFS}/")
FILES+=("${THISD}/mongodb.conf" "${ROOTFS}/etc/")

## List of script that will be running on rootfs after package has been
## installed.
## The script path is relative to rootfs.
## Do not use the name bootstrap.sh because it was preserved for main script.
BOOTSTRAP_S+=("/bootstrap_rootfs.sh")
