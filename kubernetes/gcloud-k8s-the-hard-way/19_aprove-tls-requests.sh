#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/06-kubernetes-worker.md

gcloud compute ssh controller0 --command "
    echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

    for line in \$(kubectl get csr | cut -d' ' -f1); do
        if [[ \$line != 'NAME' ]]; then
            kubectl certificate approve \$line
        fi
    done

    kubectl get nodes
"
