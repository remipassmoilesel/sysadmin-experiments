#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

mkdir -p certs && cd certs

export CA_PATH="../ca"

# ADMIN CLIENT CERT
# ADMIN CLIENT CERT
# ADMIN CLIENT CERT
# ADMIN CLIENT CERT
# ADMIN CLIENT CERT
echo ADMIN CLIENT CERT

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:masters",
      "OU": "Cluster",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=$CA_PATH/ca.pem \
  -ca-key=$CA_PATH/ca-key.pem \
  -config=$CA_PATH/ca-config.json \
  -profile=kubernetes \
  admin-csr.json | cfssljson -bare admin

# KUBE PROXY CERT
# KUBE PROXY CERT
# KUBE PROXY CERT
# KUBE PROXY CERT
# KUBE PROXY CERT
echo KUBE PROXY CERT

cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:node-proxier",
      "OU": "Cluster",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=$CA_PATH/ca.pem \
  -ca-key=$CA_PATH/ca-key.pem \
  -config=$CA_PATH/ca-config.json \
  -profile=kubernetes \
  kube-proxy-csr.json | cfssljson -bare kube-proxy

# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
echo KUBERNETES SERVER CERT

export KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region us-central1 \
  --format 'value(address)')

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "hosts": [
    "10.32.0.1",
    "10.240.0.10",
    "10.240.0.11",
    "10.240.0.12",
    "${KUBERNETES_PUBLIC_ADDRESS}",
    "127.0.0.1",
    "kubernetes.default"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Cluster",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=$CA_PATH/ca.pem \
  -ca-key=$CA_PATH/ca-key.pem \
  -config=$CA_PATH/ca-config.json \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes


