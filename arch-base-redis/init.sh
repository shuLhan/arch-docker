#!/bin/bash

echo never > /sys/kernel/mm/transparent_hugepage/enabled
redis-server /etc/redis.conf
