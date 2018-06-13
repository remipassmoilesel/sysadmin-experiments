#!/usr/bin/env bash

set -x
. config.sh

echo Deploying $1 nginx replicas
echo Deploying $1 nginx replicas
echo Deploying $1 nginx replicas

DEPLOYMENT="nginx-$(date +%Y-%m-%d-%H-%M-%S)"

kubectl run $DEPLOYMENT --image=nginx --replicas=$1 --port=80

kubectl expose deployment $DEPLOYMENT --port=80 --type=LoadBalancer
