#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/06-kubernetes-worker.md

set -x
source config.sh

for host in "$IP_W1" "$IP_W2" "$IP_W3"; do

    echo "Connection to ${host}"

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        cat /etc/systemd/system/kubelet.service

        systemctl status kubelet --no-pager
        systemctl status kube-proxy --no-pager
        systemctl status docker --no-pager

    "

done