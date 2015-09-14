# arch-docker

Script to create docker images based on Arch Linux on x86_64.

## Base Image

Size: 114M.

Base image generated using modified `pacstrap` script from
`arch-install-script` package. This image use or containts,

* `arch-base` as hostname,
* `UTC` as timezone,
* `en_GB.UTF-8` as locale,
* `ansi`, `cygwin`, `linux`, `screen-256color`, `vt100`,
`vt220`, and `xterm` in terminfo;
* explicitly installed packages are `bash`, `coreutils`, `ca-certificates`, `pacman`, `sed`, `binutils`, `file`.
, and `grep`.

To generate rootfs, execute

```
# ./create-rootfs.sh
```

This will create directory `arch-rootfs`, mounted using `tmpfs`, in the current
directory. You can modified the rootfs, and import back to docker using,

```
# ./create-image.sh
```

This will create and import image name as `sulhan/arch-base:latest`.

NOTE: remember to change the image name in `create-image.sh` if needed.

## Nodejs Image

* Base image: `sulhan/arch-base`.
* Installed packages: `git`, `gcc`, `make`, `python2`, `nodejs` and `npm`.
* This image expose port 80.

## Postgresql Image

* Base image: `sulhan/arch-base`.
* Installed packages: postgresql (plus dependencies).
* This image expose port 5432.
* Using volume in `/var/lib/postgres`.

## Jenkins Image

* Base image: `sulhan/arch-base`.
* Installed packages: `git`, `jre8-openjdk`, `jenkins`
* This image expose port 8090.
* Using volume in `/srv/www`.

## Buildbot Image

* Base image: `sulhan/arch-nodejs:latest`.
* Installed packages: `buildbot`, `buildbot-slave`.
* This image expose port 8010.
* Using volume in `/srv/www`.

## Sails image

* Base image: `sulhan/arch-nodejs:latest`.
* Installed npm packages: `sails`, `pm2`, `grunt`.
* This image expose port 80.
* Using volume in `/srv/www`.
