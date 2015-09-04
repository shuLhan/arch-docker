#!/bin/sh

ROOTFS=arch-rootfs

sudo umount -R $ROOTFS
rmdir $ROOTFS
