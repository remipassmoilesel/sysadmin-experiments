#!/usr/bin/env bash

#    Cluster network:               10.240.0.0/24     =     10.240.0.1 -> 10.240.0.254
#    K8s network (cluster-cidr):    10.200.0.0/16     =     10.200.0.1 -> 10.200.255.254
#
#    Controllers:            10.240.0.10
#                            10.240.0.11
#                            10.240.0.12
#
#    Workers:                10.240.0.20
#                            10.240.0.21
#                            10.240.0.22
#
#    Service cluster IP range, set in controller (kube-api-server), should not overlap pods cidr.
#    "A CIDR notation IP range from which to assign service cluster IPs. This must not overlap with
#      any IP ranges assigned to nodes for pods."
#
#        10.32.0.0/24      =     10.32.0.1 - 10.32.0.254
#
#    Cluster cidr, set  workers and controllers (in kube-proxy, kube-controller-manager)
#    "The CIDR range of pods in the cluster. It is used to bridge traffic coming
#      from outside of the cluster. If not provided, no off-cluster bridging will be performed."
#
#        10.200.0.0/16     =     10.200.0.1 - 10.200.255.254

export KUBERNETES_PUBLIC_ADDRESS="10.0.6.100"

export IP_M1="10.0.6.100"
export IP_M2="10.0.6.101"
export IP_M3="10.0.6.102"
export HOST_M1="ubuntu16-k6-master1.kubernetes"
export HOST_M2="ubuntu16-k6-master2.kubernetes"
export HOST_M3="ubuntu16-k6-master3.kubernetes"

export IP_W1="10.0.6.110"
export IP_W2="10.0.6.111"
export IP_W3="10.0.6.112"
export HOST_W1="ubuntu16-k6-node1.kubernetes"
export HOST_W2="ubuntu16-k6-node2.kubernetes"
export HOST_W3="ubuntu16-k6-node3.kubernetes"

export CLUSTER_SERVICE_IP_RANGE="10.5.0.0/24"
export CLUSTER_CIDR="10.244.0.0/16"
export CLUSTER_DNS="10.0.5.1"   # modify deployment too

export DOWNLOAD_DEPENDENCIES=true

export CERT_DIR_PATH="certs"
export TOKEN_DIR_PATH="token"
export CA_DIR_PATH="ca"
export CONFIG_DIR_PATH="configs"