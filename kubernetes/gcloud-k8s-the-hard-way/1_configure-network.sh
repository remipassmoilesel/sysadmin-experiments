#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-infrastructure-gcp.md

gcloud compute networks create kubernetes-the-hard-way --mode custom

gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24 \
  --region us-central1

gcloud compute firewall-rules create allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

gcloud compute firewall-rules create allow-external \
  --allow tcp:22,tcp:3389,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

gcloud compute firewall-rules create allow-healthz \
  --allow tcp:8080 \
  --network kubernetes-the-hard-way \
  --source-ranges 130.211.0.0/22,35.191.0.0/16

gcloud compute firewall-rules list --filter "network=kubernetes-the-hard-way"