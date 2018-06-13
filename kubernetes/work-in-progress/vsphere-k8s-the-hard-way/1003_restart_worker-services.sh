#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in  "$IP_W1" "$IP_W2" "$IP_W3"; do

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        systemctl start docker


        sleep 2
        systemctl start kubelet


        sleep 2
        systemctl start kube-proxy


    "

done
