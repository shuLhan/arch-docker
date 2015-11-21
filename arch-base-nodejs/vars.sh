#!/bin/zsh

THISD=${0:a:h}

ROOTFS_SIZE=900M

PKGS+=(util-linux)
PKGS_ADD+=(git gcc make python2 nodejs npm)
PKGS_REMOVED=()

IMAGE_NAME="sulhan/arch-nodejs"
IMAGE_ARGS=(-c="VOLUME /srv/www" -c="VOLUME /root/.npm" -c="EXPOSE 80" -c="CMD /init.sh")
IMAGE_FILES_BAK+=("${ROOTFS}/root/.npm" "${THISD}/npm")

FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/bootstrap_nodejs.sh" "${ROOTFS}/")
FILES+=("${THISD}/npm" "${ROOTFS}/root/.npm")

BOOTSTRAP_S+=("/bootstrap_nodejs.sh")
