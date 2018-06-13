#!/usr/bin/env bash

set -x

echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"
echo "NOT FUNCTIONNAL FOR NOW :)"

export DATE=$(date +%Y-%m-%d-%H-%M-%S)
export LOG_DIR="log_$DATE"

mkdir -p $LOG_DIR

4_prepare-nodes.sh                 > >(tee -a $LOG_DIR/4.log) 2> >(tee -a $LOG_DIR/4.log >&2)
6_create-ca.sh                     > >(tee -a $LOG_DIR/6.log) 2> >(tee -a $LOG_DIR/6.log >&2)
7_create-tls-certs.sh              > >(tee -a $LOG_DIR/7.log) 2> >(tee -a $LOG_DIR/7.log >&2)
8_distribute-tls-certs.sh          > >(tee -a $LOG_DIR/8.log) 2> >(tee -a $LOG_DIR/8.log >&2)
10_create-bootstrap-tls-token.sh   > >(tee -a $LOG_DIR/10.log) 2> >(tee -a $LOG_DIR/10.log >&2)
11_create-configs.sh               > >(tee -a $LOG_DIR/11.log) 2> >(tee -a $LOG_DIR/11.log >&2)
12_install-etcd.sh                 > >(tee -a $LOG_DIR/12.log) 2> >(tee -a $LOG_DIR/12.log >&2)
13_check-etcd-health.sh            > >(tee -a $LOG_DIR/13.log) 2> >(tee -a $LOG_DIR/13.log >&2)
14_setup-masters.sh                > >(tee -a $LOG_DIR/14.log) 2> >(tee -a $LOG_DIR/14.log >&2)
15_check-masters.sh                > >(tee -a $LOG_DIR/15.log) 2> >(tee -a $LOG_DIR/15.log >&2)
17_setup-workers.sh                > >(tee -a $LOG_DIR/17.log) 2> >(tee -a $LOG_DIR/17.log >&2)
18_check-workers.sh                > >(tee -a $LOG_DIR/18.log) 2> >(tee -a $LOG_DIR/18.log >&2)
19_aprove-tls-requests.sh          > >(tee -a $LOG_DIR/19.log) 2> >(tee -a $LOG_DIR/19.log >&2)
20_configure-kubectl.sh            > >(tee -a $LOG_DIR/20.log) 2> >(tee -a $LOG_DIR/20.log >&2)
21_add-vxlan-flannel.sh            > >(tee -a $LOG_DIR/21.log) 2> >(tee -a $LOG_DIR/20.log >&2)
22_configure-dns-addon.sh          > >(tee -a $LOG_DIR/22.log) 2> >(tee -a $LOG_DIR/22.log >&2)
