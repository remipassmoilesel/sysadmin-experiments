#!/usr/bin/env bash

set -x
. config.sh

for host in "$IP_M1" "$IP_W1" "$IP_W2" "$IP_W3"; do

  # Upgrade system
  ssh root@${host} "

    apt-get update && apt-get install -y apt-transport-https

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

    add-apt-repository \"deb https://apt.kubernetes.io/ kubernetes-xenial main\"


    apt-get update
    apt-get install -y kubelet kubeadm kubectl

  "

done