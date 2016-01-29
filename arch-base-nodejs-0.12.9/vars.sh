#!/bin/zsh

HOSTNAME="arch-nodejs"
ROOTFS_SIZE=900M

PKGS+=(util-linux)
PKGS_ADD+=(awk gcc git grep make python2)
PKGS_REMOVED=()

IMAGE_NAME="sulhan/${HOSTNAME}-0.12.9"
IMAGE_ARGS=(-c="VOLUME /srv/www" -c="VOLUME /root/.npm" -c="EXPOSE 80"
	-c="CMD /init.sh")
IMAGE_FILES_BAK=("${ROOTFS}/root/.npm" "${PWD}/npm")

FILES=("${PWD}/init.sh" "${ROOTFS}/")
FILES+=("${PWD}/bootstrap_base_nodejs.sh" "${ROOTFS}/")
FILES+=("${PWD}/npm" "${ROOTFS}/root/.npm")
FILES+=("${PWD}/nvm" "${ROOTFS}/root/.nvm")
FILES+=("${PWD}/nvm.sh" "${ROOTFS}/etc/profile.d/")
FILES+=("${PWD}/pm2.json" "${ROOTFS}/")

BOOTSTRAP_SCRIPTS=("/bootstrap_base_nodejs.sh")
