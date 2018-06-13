#!/usr/bin/env bash

set -x
. config.sh

for host in $CONTROLLER_ADDRESSES; do

  scp common-files/keepalived.check_apiserver.sh root@${host}:~
  scp common-files/keepalived.conf root@${host}:~

  ssh root@${host} "

    set -x
    apt-get install -y keepalived

    mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak

    mv keepalived.check_apiserver.sh /etc/keepalived/check_apiserver.sh
    chmod +x /etc/keepalived/check_apiserver.sh

    cp keepalived.conf /etc/keepalived

    sed -i -E 's/    interface ::INTERFACE_NAME::/    interface ens160/g'   /etc/keepalived/keepalived.conf
    sed -i -E 's/    priority ::PRIORITY::/    priority 100/g'              /etc/keepalived/keepalived.conf
    sed -i -E 's/    mcast_src_ip ::HOST_IP::/    mcast_src_ip ${host}/g'   /etc/keepalived/keepalived.conf
    sed -i -E 's/        ::VIRTUAL_IP::/        ${VIRTUAL_IP}/g'            /etc/keepalived/keepalived.conf

    systemctl enable keepalived && systemctl restart keepalived

  "

  if [ $host == $MASTER_1_ADDRESS ]; then
    ssh root@${host} "
      sed -i -E 's/    state ::STATE::/    state MASTER/g'                    /etc/keepalived/keepalived.conf
      systemctl enable keepalived && systemctl restart keepalived
    "
  else
    ssh root@${host} "
      sed -i -E 's/    state ::STATE::/    state BACKUP/g'                    /etc/keepalived/keepalived.conf
      systemctl enable keepalived && systemctl restart keepalived
    "
  fi

done