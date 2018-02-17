#!/bin/bash
err=0
for k in $( seq 1 6 ); do

    # count how much api servers are up
    process_count=$(ps -ef | grep kube-apiserver | wc -l)

    # no api server up, sleep a little time and check again
    if [ "$process_count" = "1" ]; then
        echo "No kube-apiservers up !"
        err=$(expr $err + 1)
        sleep 3
        continue
    # some servers are up, no errors
    else
        err=0
        break
    fi
done

if [ "$err" != "0" ]; then
    echo "Stopping keepalived, no kube-apiservers up"
    systemctl stop keepalived
    exit 1
else
    exit 0
fi