#!/usr/bin/env bash

set -x
. ./config.sh

export TEST=false

if [ $TEST = true ]; then
    docker run -p 22:22 -d rastasheep/ubuntu-sshd:16.04
    ssh-keygen -f "/home/remipassmoilesel/.ssh/known_hosts" -R localhost
    ssh-keyscan -H localhost >> ~/.ssh/known_hosts
    WORKER_LIST=(localhost)
fi

for host in $WORKER_LIST; do

    # sshpass -p root ssh root@${host} "
    ssh root@${host} "

        set -x

        add-apt-repository \"deb https://apt.kubernetes.io/ kubernetes-xenial main\"
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

        add-apt-repository \
          \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\"
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

        apt-get install -y apt-transport-https

        # upgrade system
        apt-get update
        apt-get upgrade -y

        # populate hosts file
        ! grep -q '^$IP_M1' /etc/hosts && echo '$IP_M1   $ADDRESS_M1' >> /etc/hosts || echo '$IP_M1 already present'

        cat /etc/hosts

        # install docker
        apt-get install -y \
           linux-image-extra-$(uname -r) \
           linux-image-extra-virtual

        apt-get install -y \
           apt-transport-https \
           ca-certificates \
           curl \
           software-properties-common

        apt-get install -y docker-ce

        docker run hello-world

        # install k8s tools
        apt-get install -y kubelet kubeadm kubectl

    "
done

JOIN_COMMAND=$(grep -E "kubeadm join --token.+" ./kubeadm-output.txt)

echo "Joining command, using : $JOIN_COMMAND"
echo "Joining command, using : $JOIN_COMMAND"
echo "Joining command, using : $JOIN_COMMAND"
echo "Joining command, using : $JOIN_COMMAND"


for host in $WORKER_LIST; do

  #sshpass -p root ssh root@${host} "
  ssh root@${host} "

    $JOIN_COMMAND

  "

done





