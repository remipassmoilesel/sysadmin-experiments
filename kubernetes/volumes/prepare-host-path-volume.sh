#!/bin/bash

# dimanche 10 juin 2018, 17:45:52 (UTC+0200)

VOLUME_PATH=/mnt/sda1/host-path-example

minikube ssh "
	sudo mkdir -p $VOLUME_PATH
	sudo bash -c 'echo \"This file is located on k8s node.\" > $VOLUME_PATH/host-path-file.txt'
"
