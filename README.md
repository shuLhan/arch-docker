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
* explicitly installed packages are `bash`, `coreutils`, `ca-certificates`
, and `pacman`.

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
