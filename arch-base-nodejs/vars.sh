#!/bin/zsh

THISD=${0:a:h}

ROOTFS_SIZE=900M

PKGS+=(util-linux)
PKGS_ADD+=(git gcc make python2 nodejs npm)
PKGS_REMOVED=()

IMAGE_NAME="sulhan/arch-nodejs"
IMAGE_ARGS=(-c="VOLUME /srv/www" -c="EXPOSE 80" -c="CMD /init.sh")

FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/bootstrap_nodejs.sh" "${ROOTFS}/")

BOOTSTRAP_S+=("/bootstrap_nodejs.sh")
