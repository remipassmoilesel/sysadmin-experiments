#!/usr/bin/env bash

set -x
. config.sh

TOKEN=$(egrep -oh "kubeadm join --token(.+)" kubeadm-output.txt | cut -d' ' -f4)

for host in $WORKER_ADDRESSES; do
  echo ${BASH_REMATCH[1]}
       ssh root@${host} "
           kubeadm join --token $TOKEN  ${VIRTUAL_IP}:8443
       "
done
