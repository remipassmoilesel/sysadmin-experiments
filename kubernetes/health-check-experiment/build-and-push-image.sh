#!/usr/bin/env bash

# Build and push image to a distant registry

source ./.credentials.sh

#REGISTRY_ADDRESS="docker.registry.com"
IMAGE_NAME="health-check-test"
TAG="1.0"

COMPLETE_NAME=$REGISTRY_ADDRESS/$IMAGE_NAME:$TAG

docker build . -t $COMPLETE_NAME
docker push $COMPLETE_NAME