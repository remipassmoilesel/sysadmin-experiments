#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-controller.md

for host in controller0 controller1 controller2; do

    echo "Connection to ${host}"

    gcloud compute ssh ${host} --command "
        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        kubectl get componentstatuses

    "

done