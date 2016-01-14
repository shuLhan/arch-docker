#!/bin/zsh

THISD=${0:a:h}

PKGS+=("redis")
IMAGE_NAME="sulhan/arch-redis"
IMAGE_ARGS=(-c="VOLUME /var/lib/redis" -c="EXPOSE 6379" -c="CMD /init.sh")

FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/redis.conf" "${ROOTFS}/etc/")
