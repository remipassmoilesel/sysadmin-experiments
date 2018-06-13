#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3" "$IP_W1" "$IP_W2" "$IP_W3"; do

    ssh root@${host}  "

        set -x

        systemctl status docker --no-pager
        systemctl status kubelet --no-pager
        systemctl status kube-proxy --no-pager

    "

done
