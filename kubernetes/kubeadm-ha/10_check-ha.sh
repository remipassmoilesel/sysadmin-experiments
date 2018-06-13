#!/usr/bin/env bash

set -x
. config.sh

#ssh root@${MASTER_1_ADDRESS} "
#
#  #kubectl get -n kube-system configmap/kube-proxy -o yaml > kube-proxy-original.yaml
#  kubectl get -n kube-system configmap/kube-proxy -o yaml > kube-proxy.yaml
#
#  sed -i -E 's/        server: https:\/\/.+/        server: https:\/\/${VIRTUAL_IP}:8443/g' ~/kube-proxy.yaml
#
#  KUBE_PROXY_CONF=\$(cat ~/kube-proxy.yaml)
#  kubectl edit -n kube-system configmap/kube-proxy  \"\$KUBE_PROXY_CONF\"
#
#"

for host in $CONTROLLER_ADDRESSES; do
   ssh root@${host} "
       kubectl --kubeconfig /etc/kubernetes/admin.conf get pods --all-namespaces -o wide
   "
done