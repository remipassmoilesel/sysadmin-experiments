#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/09-dns-addon.md

kubectl create clusterrolebinding serviceaccounts-cluster-admin \
  --clusterrole=cluster-admin \
  --group=system:serviceaccounts

kubectl create -f https://raw.githubusercontent.com/kelseyhightower/kubernetes-the-hard-way/master/services/kubedns.yaml
kubectl --namespace=kube-system get svc

kubectl create -f https://raw.githubusercontent.com/kelseyhightower/kubernetes-the-hard-way/master/deployments/kubedns.yaml
kubectl --namespace=kube-system get pods
