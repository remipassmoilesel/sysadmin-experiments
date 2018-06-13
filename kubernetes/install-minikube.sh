#!/bin/bash

# lundi 19 mars 2018, 22:34:39 (UTC+0100)

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-linux-amd64 \
    && chmod +x minikube \
    && sudo mv minikube /usr/local/bin/

