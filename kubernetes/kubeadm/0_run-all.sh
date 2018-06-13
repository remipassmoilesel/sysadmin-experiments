#!/usr/bin/env bash

set -x

export DATE=$(date +%Y-%m-%d-%H-%M-%S)
export LOG_DIR="log_$DATE"

mkdir -p $LOG_DIR

./1_prepare-nodes.sh                > >(tee -a $LOG_DIR/1.log) 2> >(tee -a $LOG_DIR/1.log >&2)
./2_install-docker.sh               > >(tee -a $LOG_DIR/2.log) 2> >(tee -a $LOG_DIR/2.log >&2)
./3_install-kube-tools.sh           > >(tee -a $LOG_DIR/3.log) 2> >(tee -a $LOG_DIR/3.log >&2)
./4_initialize-master.sh            > >(tee -a $LOG_DIR/4.log) 2> >(tee -a $LOG_DIR/4.log >&2)
./5_join-workers-to-master.sh       > >(tee -a $LOG_DIR/5.log) 2> >(tee -a $LOG_DIR/5.log >&2)

