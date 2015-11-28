#!/bin/zsh

THISD=${0:a:h}

PKGS=(coreutils binutils findutils sed gzip file)
PKGS_REMOVED+=(file gzip sed findutils less bzip2 pcre binutils perl db gdbm linux-api-headers)
IMAGE_NAME="sulhan/arch-base"
IMAGE_ARGS=()

FILES+=("${THISD}/bootstrap_base.sh" "${ROOTFS}/")

BOOTSTRAP_S+=("/bootstrap_base.sh")
