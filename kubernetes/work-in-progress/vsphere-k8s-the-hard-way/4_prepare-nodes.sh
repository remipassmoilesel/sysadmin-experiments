#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in "$IP_W1" "$IP_W2" "$IP_W3"; do
    echo "Connection to ${host}"

    ssh root@${host} "

        set -x

        echo \"Commands executed on bash by \$USER@$host\"

        apt-get update
        apt-get upgrade -y
        apt-get install -y socat  # tool used to have full functionnalities on kubelet

    "
done

for host in "$IP_M1" "$IP_M2" "$IP_M3"; do
    echo "Connection to ${host}"

    ssh root@${host} "

        set -x

        echo \"Commands executed on bash by \$USER@$host\"

        apt-get update
        apt-get upgrade -y

    "
done