#!/usr/bin/env bash

#set -x
. config.sh

scp root@$MASTER_1_ADDRESS:/etc/kubernetes/admin.conf kube-admin.conf

echo Available PODS

PODS=$(kubectl --kubeconfig=kube-admin.conf get pod --all-namespaces -o=custom-columns=NAME:.metadata.name)

kubectl --kubeconfig=kube-admin.conf get pod --all-namespaces -o wide

for line in $PODS; do

  if [ $line != "NAME" ]; then

    [[ $line == kube-controller-manager* ]] && kubectl --kubeconfig=kube-admin.conf logs -n kube-system $line

  fi

done