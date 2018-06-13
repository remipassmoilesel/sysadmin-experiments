#!/usr/bin/env bash

set -x
. config.sh

# TODO: use HTTPS

ETCD_INITIAL_CLUSTER=""
for host in $CONTROLLER_ADDRESSES; do
    ETCD_INITIAL_CLUSTER="$ETCD_INITIAL_CLUSTER,etcd-${host}=http://${host}:2380"
done

for host in $CONTROLLER_ADDRESSES; do

    ssh root@${host} "

    set -x

    docker stop etcd && docker rm etcd

    mkdir -p /var/lib/etcd

    docker run -d \
        --restart always \
        -v /etc/ssl/certs:/etc/ssl/certs \
        -v /var/lib/etcd-cluster:/var/lib/etcd \
        -p 4001:4001 \
        -p 2380:2380 \
        -p 2379:2379 \
        --name etcd \
        gcr.io/google_containers/etcd-amd64:3.0.17 \
        etcd  --name=etcd-${host} \
              --advertise-client-urls=http://${host}:2379,http://${host}:4001 \
              --listen-client-urls=http://0.0.0.0:2379,http://0.0.0.0:4001 \
              --initial-advertise-peer-urls=http://${host}:2380 \
              --listen-peer-urls=http://0.0.0.0:2380 \
              --initial-cluster-token=9477af68bbee1b9ae037d6fd9e7efefd \
              --initial-cluster=${ETCD_INITIAL_CLUSTER}\
              --initial-cluster-state=new \
              --auto-tls \
              --peer-auto-tls \
              --data-dir=/var/lib/etcd
    "
done