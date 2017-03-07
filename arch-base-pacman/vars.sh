#!/bin/zsh

## Default environment if its not set
export HOSTNAME="arch-base"
#export LANG=C.UTF-8
#export BOOT_LANG=en_GB.UTF-8
#export TIMEZONE=UTC
#export LOCALES=(
#	"en_GB.UTF-8 UTF-8"
#	"en_US.UTF-8 UTF-8"
#)

PKGS=(pacman)
PKGS_REMOVED=()

IMAGE_NAME="sulhan/arch-base-pacman"
IMAGE_ARGS=()
