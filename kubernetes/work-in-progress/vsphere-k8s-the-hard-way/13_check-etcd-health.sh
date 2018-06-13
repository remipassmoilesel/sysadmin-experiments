#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in "$IP_M1" "$IP_M2" "$IP_M3"; do

    echo "Connection to ${host}"

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

         etcdctl \\
          --ca-file=/etc/etcd/ca.pem \\
          --cert-file=/etc/etcd/kubernetes.pem \\
          --key-file=/etc/etcd/kubernetes-key.pem \\
          cluster-health
    "

done