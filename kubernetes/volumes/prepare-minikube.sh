#!/bin/bash

# dimanche 10 juin 2018, 17:45:52 (UTC+0200)

HOST_PATH_VOLUME=/mnt/sda1/host-path-example-volume

minikube ssh "
	sudo mkdir -p $HOST_PATH_VOLUME
	sudo bash -c 'echo \"This file is located on k8s node.\" > $HOST_PATH_VOLUME/host-path-file.txt'
    echo $HOST_PATH_VOLUME ready !
"

NFS_VOLUME=/mnt/sda1/nfs-example-volume

minikube ssh "
	sudo mkdir -p $NFS_VOLUME
	sudo bash -c 'echo \"This file is located on k8s node.\" > $NFS_VOLUME/nfs-file.txt'
	echo $NFS_VOLUME ready !
"

