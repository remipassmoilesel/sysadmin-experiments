#!/usr/bin/env bash

set -x
. config.sh

echo Deploying $1 nginx replicas
echo Deploying $1 nginx replicas
echo Deploying $1 nginx replicas

DEPLOYMENT="nginx-$(date +%Y-%m-%d-%H-%M-%S)"

kubectl run $DEPLOYMENT --image=nginx --replicas=$1 --port=80
kubectl expose deployment $DEPLOYMENT --port=80 --type=LoadBalancer

#kubectl run nginx1 --image=nginx --replicas=5 --port=80
#kubectl expose deployment nginx1 --port=80 --type=LoadBalancer
