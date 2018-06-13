#!/usr/bin/env bash

set -x
. config.sh

ssh root@${MASTER_1_ADDRESS} "

  kubectl get -n kube-system configmap/kube-proxy -o yaml > kube-proxy-original.yaml
  kubectl get -n kube-system configmap/kube-proxy -o yaml > kube-proxy.yaml

  sed -i -E 's/        server: https:\/\/.+/        server: https:\/\/${VIRTUAL_IP}:8443/g' ~/kube-proxy.yaml

  kubectl delete -n kube-system configmap/kube-proxy
  kubectl -n kube-system apply -f kube-proxy.yaml

  systemctl restart docker kubelet keepalived

"

ssh root@${MASTER_1_ADDRESS} "
   kubectl --kubeconfig=/etc/kubernetes/admin.conf patch node k8s-master1 -p '{\"spec\":{\"unschedulable\":true}}'
   kubectl --kubeconfig=/etc/kubernetes/admin.conf patch node k8s-master2 -p '{\"spec\":{\"unschedulable\":true}}'
   kubectl --kubeconfig=/etc/kubernetes/admin.conf patch node k8s-master3 -p '{\"spec\":{\"unschedulable\":true}}'
"



