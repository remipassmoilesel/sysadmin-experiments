#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

mkdir token && cd token

export BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF

for host in controller0 controller1 controller2; do
  gcloud compute scp token.csv ${host}:~/
done