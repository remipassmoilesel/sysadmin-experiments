#!/usr/bin/env bash

CONFIG_NAME="config.yaml"
MASTER_ADDRESS="https://10.0.5.10:6443"

# Method 1: use embedded keys
CA_PATH="/etc/kubernetes/ssl/ca.pem"
CLIENT_KEY="/etc/kubernetes/ssl/admin-10.0.5.10-key.pem"
CLIENT_CERT="/etc/kubernetes/ssl/admin-10.0.5.10.pem"

## Method 2: use password
#USERNAME="kube"
#PASSWORD="changeme"

CLUSTER_NAME="kubespray-cluster"
CLUSTER_USER_NAME="kubespray-cluster-admin"

CONTEXT_NAME="default-system"

kubectl config set-cluster "$CLUSTER_NAME" --server="$MASTER_ADDRESS" \
    --embed-certs=true \
    --certificate-authority="$CA_PATH" \
    --kubeconfig="$CONFIG_NAME"

# Method 1: use embedded keys
kubectl config set-credentials "$CLUSTER_USER_NAME" \
    --embed-certs=true \
    --certificate-authority="$CA_PATH" \
    --client-key="$CLIENT_KEY" \
    --client-certificate="$CLIENT_CERT" \
    --kubeconfig="$CONFIG_NAME"

## Method 2: use password
#kubectl config set-credentials "$CLUSTER_USER_NAME" \
#    --embed-certs=true \
#    --username="$USERNAME" \
#    --password="$PASSWORD" \
#    --kubeconfig="$CONFIG_NAME"

kubectl config set-context "$CONTEXT_NAME" --cluster="$CLUSTER_NAME" --user="$CLUSTER_USER_NAME" \
    --kubeconfig="$CONFIG_NAME"

kubectl config use-context "$CONTEXT_NAME" \
    --kubeconfig="$CONFIG_NAME"