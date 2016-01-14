#!/bin/sh

docker run --net=host --rm \
	-v $PWD/data.mongodb:/data/db \
	-it sulhan/arch-mongodb
