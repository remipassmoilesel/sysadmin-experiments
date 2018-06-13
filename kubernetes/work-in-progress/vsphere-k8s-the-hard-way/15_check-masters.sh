#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-controller.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3"; do

    echo "Connection to ${host}"

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        kubectl get componentstatuses

    "

done