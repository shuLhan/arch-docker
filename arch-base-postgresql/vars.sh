#!/bin/zsh

HOSTNAME="arch-postgresql"

PKGS=(coreutils binutils findutils sed gzip file util-linux)
PKGS_ADD=("postgresql")
PKGS_REMOVED=(file gzip sed findutils less bzip2 pcre binutils util-linux)

IMAGE_NAME="sulhan/${HOSTNAME}"
IMAGE_ARGS=(-c="VOLUME /var/lib/postgres" -c="EXPOSE 5432" -c="CMD /init.sh")

FILES=("${PWD}/pg_hba.conf" "${ROOTFS}/")
FILES+=("${PWD}/postgresql.conf" "${ROOTFS}/")
FILES+=("${PWD}/init.sh" "${ROOTFS}/")
FILES+=("${PWD}/bootstrap_postgresql.sh" "${ROOTFS}/")

BOOTSTRAP_SCRIPTS=("/bootstrap_postgresql.sh")
