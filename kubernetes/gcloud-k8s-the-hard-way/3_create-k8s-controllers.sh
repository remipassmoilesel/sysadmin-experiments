#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-infrastructure-gcp.md

gcloud compute instances create controller0 \
 --boot-disk-size 200GB \
 --can-ip-forward \
 --image ubuntu-1604-xenial-v20170307 \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --private-network-ip 10.240.0.10 \
 --subnet kubernetes

gcloud compute instances create controller1 \
 --boot-disk-size 200GB \
 --can-ip-forward \
 --image ubuntu-1604-xenial-v20170307 \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --private-network-ip 10.240.0.11 \
 --subnet kubernetes

gcloud compute instances create controller2 \
 --boot-disk-size 200GB \
 --can-ip-forward \
 --image ubuntu-1604-xenial-v20170307 \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --private-network-ip 10.240.0.12 \
 --subnet kubernetes