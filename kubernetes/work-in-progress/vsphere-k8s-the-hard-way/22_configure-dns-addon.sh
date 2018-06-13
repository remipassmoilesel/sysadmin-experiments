#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/09-dns-addon.md

set -x
. config.sh

cd $CONFIG_DIR_PATH

kubectl create clusterrolebinding serviceaccounts-cluster-admin \
  --clusterrole=cluster-admin \
  --group=system:serviceaccounts \
  --kubeconfig=client.kubeconfig

kubectl create -f ../deployments/kubedns-service.yaml \
  --kubeconfig=client.kubeconfig

kubectl create -f ../deployments/kubedns-deployment.yaml \
  --kubeconfig=client.kubeconfig

kubectl --namespace=kube-system get services --all-namespaces \
  --kubeconfig=client.kubeconfig

kubectl --kubeconfig=client.kubeconfig --all-namespaces \
  --namespace=kube-system get pods
