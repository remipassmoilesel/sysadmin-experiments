#!/bin/bash

# mercredi 30 mai 2018, 17:51:16 (UTC+0200)

set -x

eval $(minikube docker-env)
docker build docker-image -t volumes-examples:0.1
