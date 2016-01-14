#!/bin/zsh

docker run --net=host --rm -v $PWD/data.redis:/var/lib/redis -it sulhan/arch-redis
