#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/09-dns-addon.md

set -x
. config.sh

cd $CONFIG_DIR_PATH

kubectl create -f https://git.io/kube-dashboard \
          --kubeconfig=client.kubeconfig

kubectl --namespace=kube-system get pods \
            --kubeconfig=client.kubeconfig


