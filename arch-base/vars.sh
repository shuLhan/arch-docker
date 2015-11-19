#!/bin/zsh

THISD=${0:a:h}

PKGS+=(coreutils ca-certificates pacman sed binutils file grep)
PKGS_REMOVED+=(perl db)
IMAGE_NAME="sulhan/arch-base"

FILES+=("${THISD}/pacman.conf" "$ROOTFS/etc")
FILES+=("${THISD}/bootstrap_base.sh" "${ROOTFS}/")

BOOTSTRAP_S+=("/bootstrap_base.sh")
