#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in  $CONTROLLER_ADDRESSES $WORKER_LIST; do

    ssh root@${host}  "

        set -x

        reboot now

    "

done
