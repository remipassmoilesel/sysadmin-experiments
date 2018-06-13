#!/usr/bin/env bash

set -x
. config.sh

kubectl --kubeconfig=./kube-config create -f https://git.io/kube-dashboard

echo "Waiting 10 seconds ..."
sleep 10

echo "Dashboard should be available here: http://localhost/ui"
kubectl --kubeconfig=./kube-config proxy -p 8080

