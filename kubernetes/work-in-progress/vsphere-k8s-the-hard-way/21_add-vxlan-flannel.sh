#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/09-dns-addon.md

set -x
. config.sh

# On all nodes
for host in  "$IP_M1" "$IP_M2" "$IP_M3" "$IP_W1" "$IP_W2" "$IP_W3"; do

  ssh root@${host} "

      mkdir -p /opt/cni/bin && cd /opt/cni/bin
      wget https://github.com/containernetworking/cni/releases/download/v0.5.1/cni-amd64-v0.5.1.tgz -q
      tar -xf cni-amd64-v0.5.1.tgz

  "

done

cd $CONFIG_DIR_PATH

kubectl apply -f ../deployments/kube-flannel-rbac.yml \
        --kubeconfig=client.kubeconfig

kubectl apply -f ../deployments/kube-flannel.yml \
        --kubeconfig=client.kubeconfig

echo "Waiting 10 seconds ..."
sleep 10