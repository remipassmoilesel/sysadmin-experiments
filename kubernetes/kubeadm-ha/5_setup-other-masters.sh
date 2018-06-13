#!/usr/bin/env bash

set -x
. config.sh

rm -rf common-files/etc.kubernetes

scp -r root@$MASTER_1_ADDRESS:/etc/kubernetes common-files/etc.kubernetes

for host in $CONTROLLER_ADDRESSES; do

  if [ $host != $MASTER_1_ADDRESS ]; then
    scp -r common-files/etc.kubernetes/*   root@${host}:/etc/kubernetes
  fi

  ssh root@${host} "

    sed -i -E 's/    - --advertise-address=.+/    - --advertise-address=${VIRTUAL_IP}/g' /etc/kubernetes/manifests/kube-apiserver.yaml

    sed -i -E 's/    server: https:\/\/.+/    server: https:\/\/${VIRTUAL_IP}:6443/g' /etc/kubernetes/kubelet.conf
    sed -i -E 's/    server: https:\/\/.+/    server: https:\/\/${VIRTUAL_IP}:6443/g' /etc/kubernetes/admin.conf
    sed -i -E 's/    server: https:\/\/.+/    server: https:\/\/${VIRTUAL_IP}:6443/g' /etc/kubernetes/controller-manager.conf
    sed -i -E 's/    server: https:\/\/.+/    server: https:\/\/${VIRTUAL_IP}:6443/g' /etc/kubernetes/scheduler.conf

    systemctl daemon-reload && systemctl restart docker kubelet

    systemctl status docker --no-pager
    systemctl status kubelet  --no-pager

    # copy config for root user
    mkdir -p /root/.kube
    cp /etc/kubernetes/admin.conf /root/.kube/config

  "

done
