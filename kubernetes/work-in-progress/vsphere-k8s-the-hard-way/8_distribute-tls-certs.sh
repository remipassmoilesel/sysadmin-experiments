#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

set -x
source config.sh

for host in "$IP_W1" "$IP_W2" "$IP_W3"; do
  scp $CA_DIR_PATH/ca.pem $CERT_DIR_PATH/kube-proxy.pem $CERT_DIR_PATH/kube-proxy-key.pem root@${host}:~/
done

for host in "$IP_M1" "$IP_M2" "$IP_M3"; do
  scp $CA_DIR_PATH/ca.pem $CA_DIR_PATH/ca-key.pem $CERT_DIR_PATH/kubernetes-key.pem $CERT_DIR_PATH/kubernetes.pem root@${host}:~/
done