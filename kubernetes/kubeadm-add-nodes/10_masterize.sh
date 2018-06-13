#!/usr/bin/env bash

set -x
. ./config.sh

export TEST=false

if [ $TEST = true ]; then
    docker run -p 22:22 -d rastasheep/ubuntu-sshd:16.04
    ssh-keygen -f "/home/remipassmoilesel/.ssh/known_hosts" -R localhost
    ssh-keyscan -H localhost >> ~/.ssh/known_hosts
    CONTROLLER_LIST=(localhost)
fi

for host in $CONTROLLER_LIST; do

    ssh root@${host} "

        set -x

        # upgrade system
        apt-get update && apt-get upgrade -y

        # install docker
        apt-get install -y \
            linux-image-extra-$(uname -r) \
            linux-image-extra-virtual

        apt-get install -y \
           apt-transport-https \
           ca-certificates \
           curl \
           software-properties-common

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

        add-apt-repository \
            \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\"

        apt-get update
        apt-get install -y docker-ce

        docker run hello-world

        # install k8s tools
        apt-get update && apt-get install -y apt-transport-https
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
        add-apt-repository \"deb https://apt.kubernetes.io/ kubernetes-xenial main\"

        apt-get update
        apt-get install -y kubelet kubeadm kubectl

        # initialize master
        kubeadm init --pod-network-cidr=10.244.0.0/16 | tee kubeadm-output.txt

        echo 'Waiting 5 seconds...'
        sleep 5

        # prepare kubectl config
        mkdir -p $HOME/.kube
        cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        chown $(id -u):$(id -g) $HOME/.kube/config

        "

    scp root@${host}:/root/kubeadm-output.txt ./kubeadm-output_$host.txt

    scp root@${host}:/root/.kube/config ./kube-config_$host

    ssh root@${host} "

        set -x

        # create network/flannel pods
        kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
        kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml

        echo 'Waiting 10 seconds...'
        sleep 10

        kubectl get pods --all-namespaces

    "
done