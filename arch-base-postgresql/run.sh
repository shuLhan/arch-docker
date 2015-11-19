#!/bin/zsh

docker run --net=host --rm -v $PWD/data:/var/lib/postgres -it sulhan/arch-postgresql
