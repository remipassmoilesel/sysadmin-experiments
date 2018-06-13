#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/07-kubectl.md

set -x
source config.sh

cd $CONFIG_DIR_PATH

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=../$CA_DIR_PATH/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443  \
  --kubeconfig=client.kubeconfig

kubectl config set-credentials admin \
  --client-certificate=../$CERT_DIR_PATH/admin.pem \
  --client-key=../$CERT_DIR_PATH/admin-key.pem  \
  --kubeconfig=client.kubeconfig

kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin  \
  --kubeconfig=client.kubeconfig

kubectl --kubeconfig=client.kubeconfig \
          config use-context kubernetes-the-hard-way

kubectl --kubeconfig=client.kubeconfig \
          get componentstatuses

kubectl --kubeconfig=client.kubeconfig \
          get nodes
