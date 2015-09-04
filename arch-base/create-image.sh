#!/bin/bash

ROOTFS=arch-rootfs

sudo tar --numeric-owner --xattrs --acls -C "$ROOTFS" -c . |
	docker import - sulhan/arch-base
