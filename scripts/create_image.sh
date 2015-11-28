#!/bin/zsh

. ../scripts/rootfs.sh
. ./vars.sh

rootfs_clean_pacman

rootfs_to_docker ${IMAGE_NAME} ${IMAGE_ARGS[@]}
