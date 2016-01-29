#!/bin/zsh

HOSTNAME="arch-redis"

PKGS=(coreutils binutils findutils sed gzip file util-linux)
PKGS_ADD=("redis")
PKGS_REMOVED=(findutils sed gzip file util-linux)

IMAGE_NAME="sulhan/${HOSTNAME}"
IMAGE_ARGS=(-c="VOLUME /var/lib/redis" -c="EXPOSE 6379" -c="CMD /init.sh")

FILES=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/redis.conf" "${ROOTFS}/etc/")
