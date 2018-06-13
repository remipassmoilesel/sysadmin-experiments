#!/usr/bin/env bash

set -x
. config.sh

for host in $CONTROLLER_ADDRESSES; do

    ssh root@${host} "

    set -x

    echo ${host}
    docker exec etcd /bin/sh -c 'etcdctl member list; etcdctl cluster-health'

    "
done