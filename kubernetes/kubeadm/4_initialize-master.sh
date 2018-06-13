#!/usr/bin/env bash

set -x
. config.sh

# Upgrade system
ssh root@${IP_M1} "

  kubeadm init --pod-network-cidr=10.244.0.0/16 | tee kubeadm-output.txt

  # prepare kubectl config
  mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config

"

scp root@${IP_M1}:/root/kubeadm-output.txt .
scp root@${IP_M1}:/root/.kube/config ./kube-config

ssh root@${IP_M1} "

  # create network/flannel pods
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml

  echo 'Waiting 10 seconds...'
  sleep 10

  kubectl get pods --all-namespaces

"
