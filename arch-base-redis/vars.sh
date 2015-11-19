#!/bin/zsh

THISD=${0:a:h}

PKGS+=("redis")
IMAGE_NAME="sulhan/arch-redis"

FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/redis.conf" "${ROOTFS}/etc/")
