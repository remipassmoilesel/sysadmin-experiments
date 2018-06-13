#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

export CA_PATH="ca"
export CERT_PATH="certs"

for host in worker0 worker1 worker2; do
  gcloud compute scp $CA_PATH/ca.pem $CERT_PATH/kube-proxy.pem $CERT_PATH/kube-proxy-key.pem ${host}:~/
done

for host in controller0 controller1 controller2; do
  gcloud compute scp $CA_PATH/ca.pem $CA_PATH/ca-key.pem $CERT_PATH/kubernetes-key.pem $CERT_PATH/kubernetes.pem ${host}:~/
done