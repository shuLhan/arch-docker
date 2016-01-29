#!/bin/zsh

HOSTNAME="arch-base-devel"

PKGS=(coreutils binutils findutils sed gzip file util-linux)
PKGS_ADD=(awk gcc git grep make python2)
PKGS_REMOVED=()
IMAGE_NAME="sulhan/${HOSTNAME}"
IMAGE_ARGS=()
