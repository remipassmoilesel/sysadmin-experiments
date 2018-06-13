#!/usr/bin/env bash

# Create a secret used to access docker registry in current k8s cluster

source ./.credentials.sh

DOCKER_REG_ADDRESS=https://docker.bbuzcloud.com/
#DOCKER_REG_USERNAME=user
#DOCKER_REG_PASSWORD=password
DOCKER_REG_EMAIL=mail@domain.com

kubectl create secret docker-registry regsecret \
    --docker-server=$DOCKER_REG_ADDRESS \
    --docker-username=$DOCKER_REG_USERNAME \
    --docker-password=$DOCKER_REG_PASSWORD \
    --docker-email=$DOCKER_REG_EMAIL
