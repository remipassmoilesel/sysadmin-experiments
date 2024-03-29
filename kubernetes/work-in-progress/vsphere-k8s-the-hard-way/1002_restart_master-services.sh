#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3"; do

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        systemctl restart etcd

        sleep 2
        systemctl start kube-apiserver

        sleep 2
        systemctl start kube-controller-manager

        sleep 2
        systemctl start kube-scheduler

    "

done
