#!/bin/zsh

HOSTNAME="arch-gulp-etal"
ROOTFS_SIZE=900M

PKGS=(util-linux)
PKGS_ADD=(git gcc make python2 nodejs npm)

IMAGE_NAME="sulhan/${HOSTNAME}"
IMAGE_ARGS=(-c="VOLUME /srv/www" -c="VOLUME /root/.npm" -c="EXPOSE 10000" -c="CMD /init.sh")
IMAGE_FILES_BAK=("${ROOTFS}/root/.npm" "${THISD}/npm")

FILES=("${PWD}/init.sh" "${ROOTFS}/")
FILES+=("${PWD}/bootstrap_gulp_etal.sh" "${ROOTFS}/")
FILES+=("${PWD}/npm" "${ROOTFS}/root/.npm")

BOOTSTRAP_SCRIPTS=("/bootstrap_gulp_etal.sh")
