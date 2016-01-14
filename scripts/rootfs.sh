#!/bin/zsh

## Get script directory.
export SCRIPTD=${0:a:h}

export ROOTFS=arch-rootfs
export ROOTFS_SIZE=400M

## List of packages to be installed
export PKGS=()

## List of additional to be installed after main PKGS
export PKGS_ADD=()

## List of files and their destination to be copied to rootfs.
## Using associative array.
typeset -A FILES

## List of files in rootfs to be backed up and removed before creating the
## docker image.
typeset -A IMAGE_FILES_BAK

FILES=(${SCRIPTD}/bootstrap.sh ${ROOTFS}/)

rootfs_must_root() {
	if [[ $EUID != 0 ]]; then
		echo "This script must be run with root privileges"
		exit 1
	fi
}

rootfs_create() {
	echo "==> create rootfs ${ROOTFS}"
	mkdir -p $ROOTFS
}

rootfs_mount() {
	echo "==> mounting ${ROOTFS} as tmpfs"
	## safety first, make sure we do not mount rootfs recursively
	umount -R "$ROOTFS"
	mount -t tmpfs -o size=${ROOTFS_SIZE} tmpfs "$ROOTFS"
}

rootfs_install() {
	${SCRIPTD}/pacstrap.sh -c -d "$ROOTFS" ${PKGS}

	if [[ ${#PKGS_ADD} > 0 ]]; then
		${SCRIPTD}/pacstrap.sh -c -d "$ROOTFS" ${PKGS_ADD}
	fi
}

rootfs_copy() {
	echo "==> copying files ..."

	for k in "${(@k)FILES}"; do
		echo "    from $k to $FILES[$k]"
		if [ -h $k ]; then
			cp -rL $k $FILES[$k]
			chown -R root:root $FILES[$k]
		elif [ -d $k ]; then
			cp -r $k $FILES[$k]
			chown -R root:root $FILES[$k]
		elif [ -f $k ]; then
			cp $k $FILES[$k]
			chown root:root $FILES[$k]
		fi
	done
}

rootfs_bootstrap() {
	RUN_BOOTSTRAP="${ROOTFS}/run_bootstrap.sh"
	VAR_BOOTSTRAP="${ROOTFS}/vars.sh"

	echo "==> bootstraping ... ${RUN_BOOTSTRAP}"

	## generate vars for bootstrap
	echo '#!/bin/bash' > ${VAR_BOOTSTRAP}
	echo "PKGS_REMOVED=($PKGS_REMOVED)" >> ${VAR_BOOTSTRAP}

	## generate bootstrap script.
	echo '#!/bin/bash' > ${RUN_BOOTSTRAP}
	echo '. ./vars.sh' >> ${RUN_BOOTSTRAP}

	for (( i = 1; i <= ${#BOOTSTRAP_S}; i++ )) do
		echo ". $BOOTSTRAP_S[$i]" >> ${RUN_BOOTSTRAP}
	done
	chmod +x ${RUN_BOOTSTRAP}

	## run the bootstrap script.
	${SCRIPTD}/arch-chroot.sh "$ROOTFS" /bin/sh -c "/`basename ${RUN_BOOTSTRAP}`"
	wait
}

rootfs_uninstall() {
	echo "==> uninstalling packages ..."
	if [[ ${#PKGS_REMOVED} > 0 ]]; then
		pacman -r "$ROOTFS" -Rdd --noconfirm ${PKGS_REMOVED}
	fi
}

rootfs_clean_pacman() {
	echo "==> remove pacman db and local ..."
	rm -rf "${ROOTFS}/var/lib/pacman/sync/*"
	rm -rf "${ROOTFS}/var/lib/pacman/local/*"
}

##
## (1) set root fs.
## (2) create root fs directory.
## (3) mount root fs as tmpfs.
## (4) run pacstrap.
## (5) copy bootstrap script and default pacman config.
## (6) run bootstrap script in new root fs.
##
rootfs_main() {
	rootfs_clean
	rootfs_create
	rootfs_mount
	rootfs_install
	rootfs_copy
	rootfs_bootstrap
	rootfs_uninstall
}

rootfs_backup() {
	echo "==> creating backups ..."

	for k in "${(@k)IMAGE_FILES_BAK}"; do
		echo "    from $k to $IMAGE_FILES_BAK[$k]"
		if [ -f $k ]; then
			cp $k $IMAGE_FILES_BAK[$k] && rm $k
		elif [ -d $k ]; then
			cp -r $k $IMAGE_FILES_BAK[$k] && rm -rf $k
		fi
	done
}

##
## Convert rootfs to docker image.
##
rootfs_to_docker() {
	rootfs_backup

	sudo tar --numeric-owner --xattrs --acls -C "$ROOTFS" -c . |
		docker import ${@:2} - $1
}

##
## Unmount and remove rootfs.
##
rootfs_clean() {
	sudo umount -R $ROOTFS
	rm -f ${ROOTFS}/*
	rmdir ${ROOTFS}
}
