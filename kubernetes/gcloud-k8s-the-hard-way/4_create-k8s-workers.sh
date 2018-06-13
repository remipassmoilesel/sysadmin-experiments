#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-infrastructure-gcp.md

# Include socat depedency on worker VMs to enable kubelet's portfw functionality.

gcloud compute instances create worker0 \
 --boot-disk-size 200GB \
 --can-ip-forward \
 --image ubuntu-1604-xenial-v20170307 \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --private-network-ip 10.240.0.20 \
 --subnet kubernetes \
 --metadata startup-script='#! /bin/bash
apt-get update
apt-get install -y socat
EOF'

gcloud compute instances create worker1 \
 --boot-disk-size 200GB \
 --can-ip-forward \
 --image ubuntu-1604-xenial-v20170307 \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --private-network-ip 10.240.0.21 \
 --subnet kubernetes \
 --metadata startup-script='#! /bin/bash
apt-get update
apt-get install -y socat
EOF'

gcloud compute instances create worker2 \
 --boot-disk-size 200GB \
 --can-ip-forward \
 --image ubuntu-1604-xenial-v20170307 \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --private-network-ip 10.240.0.22 \
 --subnet kubernetes \
 --metadata startup-script='#! /bin/bash
apt-get update
apt-get install -y socat
EOF'