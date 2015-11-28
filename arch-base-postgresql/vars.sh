#!/bin/zsh

THISD=${0:a:h}

PKGS+=("util-linux")
PKGS_ADD+=("postgresql")

IMAGE_NAME="sulhan/arch-postgresql"
IMAGE_ARGS=(-c="VOLUME /var/lib/postgres" -c="EXPOSE 5432" -c="CMD /init.sh")

FILES+=("${THISD}/pg_hba.conf" "${ROOTFS}/")
FILES+=("${THISD}/postgresql.conf" "${ROOTFS}/")
FILES+=("${THISD}/init.sh" "${ROOTFS}/")
FILES+=("${THISD}/bootstrap_postgresql.sh" "${ROOTFS}/")

BOOTSTRAP_S+=("/bootstrap_postgresql.sh")
