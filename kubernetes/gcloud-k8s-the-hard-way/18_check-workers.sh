#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/06-kubernetes-worker.md

for host in worker0 worker1 worker2; do

    echo "Connection to ${host}"

    gcloud compute ssh ${host} --command "
        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        cat /etc/systemd/system/kubelet.service

        sudo systemctl status kubelet --no-pager
        sudo systemctl status kube-proxy --no-pager
        sudo systemctl status docker --no-pager

    "

done