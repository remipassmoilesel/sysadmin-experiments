#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3"; do

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        systemctl start kube-apiserver
        systemctl status kube-apiserver --no-pager

        systemctl start kube-controller-manager
        systemctl status kube-controller-manager --no-pager

        systemctl start kube-scheduler
        systemctl status kube-scheduler --no-pager

    "

done
