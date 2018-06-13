#!/usr/bin/env bash

set -x
. config.sh

JOIN_COMMAND=$(grep -E "kubeadm join --token.+" kubeadm-output.txt)


for host in "$IP_W1" "$IP_W2" "$IP_W3"; do

  # Upgrade system
  ssh root@${host} "

    $JOIN_COMMAND

  "

done