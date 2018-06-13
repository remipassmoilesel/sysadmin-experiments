#!/usr/bin/env bash

set -x
. config.sh

for host in "$IP_M1" "$IP_W1" "$IP_W2" "$IP_W3"; do

  # Upgrade system
  ssh root@${host} "

   apt-get install -y \
      linux-image-extra-$(uname -r) \
      linux-image-extra-virtual

   apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common

   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

   add-apt-repository \
       \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable\"

   apt-get update

   apt-get install -y docker-ce

   docker run hello-world

  "

done