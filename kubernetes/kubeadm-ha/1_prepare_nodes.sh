#!/usr/bin/env bash

set -x
. config.sh

# TODO: change kubeadm join process
# TODO: etcd cluster should use tls
# TODO: check if kubelet and docker modification of cgroups is necessary

for host in $WORKER_ADDRESSES $CONTROLLER_ADDRESSES; do

  ssh root@${host} "

    # upgrade system
    # upgrade system
    # upgrade system
    # upgrade system

    apt-get update
    apt-get upgrade -y

    # install helpers
    # install helpers
    # install helpers
    # install helpers


    apt-get install -y \
      linux-image-extra-$(uname -r) \
      linux-image-extra-virtual

    apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common


    # add docker repo
    # add docker repo
    # add docker repo
    # add docker repo

     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

     add-apt-repository \
         \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\"

     # add kube tools repo
     # add kube tools repo
     # add kube tools repo
     # add kube tools repo
     # add kube tools repo
     # add kube tools repo

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

    add-apt-repository \"deb https://apt.kubernetes.io/ kubernetes-xenial main\"


    # install docker and kube tools
    # install docker and kube tools
    # install docker and kube tools
    # install docker and kube tools


    apt-get update
    apt-get install -y kubelet kubeadm kubectl
    apt-get install -y docker-ce

    # docker run hello-world

  "

  # change behavior of docker daemon
  scp common-files/docker.service root@${host}:~

  ssh root@${host} "
    cp /root/docker.service /lib/systemd/system/
    systemctl daemon-reload
    systemctl restart docker
  "

done