#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

for host in controller0 controller1 controller2; do

    echo "Connection to ${host}"

    gcloud compute ssh ${host} --command "
        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        sudo etcdctl \\
          --ca-file=/etc/etcd/ca.pem \\
          --cert-file=/etc/etcd/kubernetes.pem \\
          --key-file=/etc/etcd/kubernetes-key.pem \\
          cluster-health
    "

done