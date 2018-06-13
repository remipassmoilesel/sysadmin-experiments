#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

set -x
source config.sh

mkdir -p $TOKEN_DIR_PATH && cd $TOKEN_DIR_PATH

export BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF

for host in "$IP_M1" "$IP_M2" "$IP_M3"; do
  scp token.csv root@${host}:~/
done