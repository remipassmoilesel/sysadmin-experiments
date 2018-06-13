#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-infrastructure-gcp.md

gcloud compute addresses create kubernetes-the-hard-way --region=us-central1
gcloud compute addresses list kubernetes-the-hard-way
