#!/usr/bin/env bash

# watch -n 2 ./12_count-docker-instances.sh

# set -x
. ./config.sh

TEST_MODE=false

echo "Counting instances $1"

if [ $TEST_MODE = true ]; then
    for i in $(seq 1 10); do
        ssh $USER@localhost "
            docker run -d nginx
        "
    done
fi

for host in $WORKER_LIST; do
    ssh $USER@localhost "
       echo $host:  \$(docker ps -f ancestor=$1 -q | wc -l)
    "
done


