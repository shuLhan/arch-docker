#!/bin/bash

##
## (1) set root fs.
## (2) create root fs directory.
## (3) mount root fs as tmpfs.
## (4) run pacstrap.
## (5) copy bootstrap script and default pacman config.
## (6) run bootstrap script in new root fs.
## (7) cleaning.
##

## (1)
export ROOTFS=arch-rootfs

## (2)
mkdir -p "$ROOTFS"

## (3)
umount -R "$ROOTFS"
mount -t tmpfs -o size=400M tmpfs "$ROOTFS"

## (4) 
./pacstrap.sh -c -d "$ROOTFS" bash coreutils ca-certificates pacman sed binutils file

## (5)
cp ./pacman.conf "$ROOTFS/etc/"
cp ./bootstrap.sh "$ROOTFS/"

## (6)
arch-chroot "$ROOTFS" /bin/sh -c /bootstrap.sh

## (7)
rm "$ROOTFS"/bootstrap.sh
