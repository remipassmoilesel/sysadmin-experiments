#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

set -x
source config.sh

mkdir -p $CERT_DIR_PATH && cd $CERT_DIR_PATH

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
  -ca=../$CA_DIR_PATH/ca.pem \
  -ca-key=../$CA_DIR_PATH/ca-key.pem \
  -config=../$CA_DIR_PATH/ca-config.json \
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
  -ca=../$CA_DIR_PATH/ca.pem \
  -ca-key=../$CA_DIR_PATH/ca-key.pem \
  -config=../$CA_DIR_PATH/ca-config.json \
  -profile=kubernetes \
  kube-proxy-csr.json | cfssljson -bare kube-proxy

# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
# KUBERNETES SERVER CERT
echo KUBERNETES SERVER CERT

#
# These values should be uneeded:
#    "${IP_W1}",
#    "${IP_W2}",
#    "${IP_W3}",
#    "${HOST_W1}",
#    "${HOST_W2}",
#    "${HOST_W3}",
#
# Internal virtual address of kube dns:
#    "10.32.0.1",

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "hosts": [
    "${KUBERNETES_PUBLIC_ADDRESS}",
    "${IP_M1}",
    "${IP_M2}",
    "${IP_M3}",
    "${HOST_M1}",
    "${HOST_M2}",
    "${HOST_M3}",
    "${IP_W1}",
    "${IP_W2}",
    "${IP_W3}",
    "${HOST_W1}",
    "${HOST_W2}",
    "${HOST_W3}",
    "127.0.0.1",
    "10.32.0.1",
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
  -ca=../$CA_DIR_PATH/ca.pem \
  -ca-key=../$CA_DIR_PATH/ca-key.pem \
  -config=../$CA_DIR_PATH/ca-config.json \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes


