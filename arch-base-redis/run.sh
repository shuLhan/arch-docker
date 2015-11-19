#!/bin/zsh

docker run --net=host --rm -v $PWD/data:/var/lib/redis -it sulhan/arch-redis
