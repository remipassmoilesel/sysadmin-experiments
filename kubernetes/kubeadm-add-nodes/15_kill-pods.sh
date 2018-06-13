#!/usr/bin/env bash

set -x
. ./config.sh

export PODS_LIST="nginx-2017-08-24-10-52-55-608464650-dcs91             \
                      nginx-2017-08-24-10-52-55-608464650-f9q7r         \
                      nginx-2017-08-24-10-52-55-608464650-j79n4         \
                      nginx-2017-08-24-10-52-55-608464650-m00k3         \
                      nginx-2017-08-24-10-52-55-608464650-m4rhs         \
                      nginx-2017-08-24-10-52-55-608464650-mhtx5         \
                      nginx-2017-08-24-10-52-55-608464650-v9kmw         \
                      nginx-2017-08-24-10-52-55-608464650-x1bz9"

kubectl --kubeconfig kube-config  delete pods $PODS_LIST