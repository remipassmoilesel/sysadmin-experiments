#!/usr/bin/env bash

set -x
. config.sh

for host in $CONTROLLER_ADDRESSES; do

  scp common-files/nginx-lb.conf root@${host}:/etc/kubernetes

  ssh root@${host} "

    set -x

    docker stop nginx-lb && docker rm nginx-lb

    docker run -d -p 8443:8443 \
        --name nginx-lb \
        --restart always \
        -v /etc/kubernetes/nginx-lb.conf:/etc/nginx/nginx.conf \
        nginx

  "

done