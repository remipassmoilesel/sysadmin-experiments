#!/usr/bin/env bash

# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-certificate-authority.md

wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
chmod +x kubectl
 mv kubectl /usr/local/bin