#!/bin/zsh

THISD=${0:a:h}

ROOTFS_SIZE=900M

PKGS+=(util-linux)
PKGS_ADD+=(awk gcc git grep make python2)
PKGS_REMOVED=()

IMAGE_NAME="sulhan/arch-nodejs-0.12.9"
IMAGE_ARGS=(-c="VOLUME /srv/www" -c="VOLUME /root/.npm" -c="EXPOSE 80"
	-c="CMD /init.sh")
IMAGE_FILES_BAK+=("${ROOTFS}/root/.npm" "${THISD}/npm")

FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/bootstrap_base_nodejs.sh" "${ROOTFS}/")
FILES+=("${THISD}/npm" "${ROOTFS}/root/.npm")
FILES+=("${THISD}/nvm" "${ROOTFS}/root/.nvm")
FILES+=("${THISD}/nvm.sh" "${ROOTFS}/etc/profile.d/")
FILES+=("${THISD}/pm2.json" "${ROOTFS}/")

BOOTSTRAP_S+=("/bootstrap_base_nodejs.sh")
