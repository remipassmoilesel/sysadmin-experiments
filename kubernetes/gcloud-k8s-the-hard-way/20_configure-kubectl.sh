#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/07-kubectl.md

export CA_PATH="ca"
export CERTS_PATH="certs"

export KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region us-central1 \
  --format 'value(address)')

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=${CA_PATH}/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials admin \
  --client-certificate=${CERTS_PATH}/admin.pem \
  --client-key=${CERTS_PATH}/admin-key.pem

kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin

kubectl config use-context kubernetes-the-hard-way

kubectl get componentstatuses

kubectl get nodes
