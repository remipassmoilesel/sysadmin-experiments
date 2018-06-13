#!/usr/bin/env bash

# https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/03-auth-configs.md

set -x
source config.sh

mkdir -p $CONFIG_DIR_PATH && cd $CONFIG_DIR_PATH

export BOOTSTRAP_TOKEN=$(awk -F "," '{print $1}' ../token/token.csv)

echo BOOTSTRAP CONFIG

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=../$CA_DIR_PATH/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=bootstrap.kubeconfig

kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=bootstrap.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig

kubectl config use-context default --kubeconfig=bootstrap.kubeconfig

echo KUBE-PROXY CONFIG

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=../$CA_DIR_PATH/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
  --client-certificate=../$CERT_DIR_PATH/kube-proxy.pem \
  --client-key=../$CERT_DIR_PATH/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig

for host in "$IP_W1" "$IP_W2" "$IP_W3"; do
  scp bootstrap.kubeconfig kube-proxy.kubeconfig root@${host}:~/
done