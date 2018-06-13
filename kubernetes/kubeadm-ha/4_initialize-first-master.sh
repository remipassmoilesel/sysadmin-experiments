#!/usr/bin/env bash

set -x
. config.sh

export DATE=$(date +%Y-%m-%d-%H-%M-%S)

# Copy config files to master 1
scp common-files/kubeadm-init.yaml root@${MASTER_1_ADDRESS}:~
scp common-files/10-kubeadm.conf root@${MASTER_1_ADDRESS}:~
scp common-files/kube-apiserver.yaml root@${MASTER_1_ADDRESS}:~

ssh root@${MASTER_1_ADDRESS} "

  set -x

  # init master 1
  rm -rf /etc/kubernetes
  kubeadm init --skip-preflight-checks --config=/root/kubeadm-init.yaml | tee ~/kubeadm-output.txt

  # change behavior of kubelet
  systemctl stop kubelet docker

  cp /etc/systemd/system/kubelet.service.d/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf.bak_$DATE
  cp 10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

  cp /etc/kubernetes/manifests/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml.bak_$DATE
  cp kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml

  systemctl daemon-reload
  systemctl start kubelet docker


  # display components
  kubectl get componentstatuses


  mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config

  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml                                                                                                                        [14:14:04]
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml
  kubectl create -f https://git.io/kube-dashboard

  sleep 60

  kubectl get pods --all-namespaces -o wide

  # set master as worker
  kubectl taint nodes --all node-role.kubernetes.io/master-


"

scp root@${MASTER_1_ADDRESS}:/root/kubeadm-output.txt  kubeadm-output.txt


