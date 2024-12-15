# Arch-Docker

Baked images is at Docker hub: https://hub.docker.com/u/sulhan/

This repository contain ZSH scripts to create Docker images based on Arch Linux
x86_64.

Docker image is just a root file system with metadata and historical values.
Each time we issued a `COPY` command or doing some things that modified the
rootfs through `Dockerfile`, docker will compute the checksum of resulting
image and find the matching image with the same size, if its found it will be
used.

This is good, it can minimize size usage in local host, but it slow.

This script bypass the usage of `Dockerfile` and directly create rootfs,
modified it, and import it to Docker as image.

<s>
Arch Linux is become bloated, I recommend to use Alpine Linux for small size
and probably faster container.
</s>

I said the above statement when I am still naive.

Arch Linux is not bloated.
Unlike other Linux distro, Arch Linux include documentation and development
files in one package, while other distro split it into "-doc" and/or
"-devel" packages.

DO NOT USE Alpine Linux just because you want smaller images.
Alpine Linux use Musl libc, the core library where every single program
depends on, which completely different with glibc that used by most Linux
distro where you probably develop and test your program.
And, no, Musl is
[not always](https://bell-sw.com/blog/alpaquita-linux-performance-the-race-is-on/)
[faster](https://users.rust-lang.org/t/optimizing-rust-binaries-observation-of-musl-versus-glibc-and-jemalloc-versus-system-alloc/8499)
than glibc.
If you did not know what is libc and why it will affect your program, please
do not use it for the sake of smaller images.


## How To

The steps to create new custom image,

* Copy directory `arch-base-template` to new directory.
* Modified the `vars.sh` script to install and/or remove packages for
  installation in rootfs.
* Modify the `bootstrap_rootfs.sh` to run specific command when creating
  rootfs.
* Modify the `init.sh` to run specific command when image is running.
* To generate rootfs, execute

  ```
  $ sudo ./create_rootfs.sh
  ```

  This will create directory `arch-rootfs`, mounted using `tmpfs`, in the
  current directory.

* You can modified the rootfs, and
* create Docker image with

  ```
  $ ./create_image.sh
  ```

* Thats it.

For an example, you can view other directory in this repository.

# Images scripts

Each directory in this repository contain the scripts and variable to create
Docker image.
The `arch-base-*` is directory where the image is created without Dockerfile,
and others directories are where the image is created using Dockerfile
using `arch-base` as the base image.

## Base Image

Base image generated using modified `pacstrap` script from
`arch-install-script` package. This image use or containts,

* Size 118M.
* Hostname using `arch-base`,
* Timezone using `UTC`,
* Locales using `en_GB.UTF-8` and `en_US.UTF-9`
* Terminfo include only `ansi`, `cygwin`, `linux`, `screen-256color`, `vt100`,
  `vt220`, and `xterm`
* Installed packages are `acl`, `attr`, `bash`, `coreutils`, `db`,
  `filesystem`, `gcc-libs`, `glibc`, `gmp`, `iana-etc`, `libcap`,
  `linux-api-headers`, `ncurses`, `openssl`, `perl`, `readline`, `tzdata`, and
  `zlib`.

The following images created using rootfs (without `Dockerfile`).

### Redis Image

* Base image: `sulhan/arch-base`.
* Installed packages: `redis`
* This image expose port 6379.
* Using volume in `/var/lib/redis`.

The following images created with Dockerfile using `arch-base` as base image:

### Nodejs Image

* Base image: `sulhan/arch-base`.
* Installed packages: `git`, `gcc`, `make`, `python2`, `nodejs` and `npm`.
* This image expose port 80.

### Postgresql Image

* Base image: `sulhan/arch-base`.
* Installed packages: postgresql (plus dependencies).
* This image expose port 5432.
* Using volume in `/var/lib/postgres`.

### Jenkins Image

* Base image: `sulhan/arch-base`.
* Installed packages: `git`, `jre8-openjdk`, `jenkins`
* This image expose port 8090.
* Using volume in `/srv/www`.

### Buildbot Image

* Base image: `sulhan/arch-nodejs:latest`.
* Installed packages: `buildbot`, `buildbot-slave`.
* This image expose port 8010.
* Using volume in `/srv/www`.

### Sails Image

* Base image: `sulhan/arch-nodejs:latest`.
* Installed npm packages: `sails`, `pm2`, `grunt`.
* This image expose port 80.
* Using volume in `/srv/www`.
