#!/usr/bin/env bash

set -x
. config.sh

for host in "$IP_M1" "$IP_W1" "$IP_W2" "$IP_W3"; do

  # Upgrade system
  ssh root@${host} "

    # upgrade system
    apt-get update
    apt-get upgrade -y

    # populate hosts file
    ! grep -q '^$IP_M1' /etc/hosts && echo '$IP_M1   $ADDRESS_M1' >> /etc/hosts || echo '$IP_M1 already present'
    ! grep -q '^$IP_W1' /etc/hosts && echo '$IP_W1   $ADDRESS_W1' >> /etc/hosts || echo '$IP_W1 already present'
    ! grep -q '^$IP_W2' /etc/hosts && echo '$IP_W2   $ADDRESS_W2' >> /etc/hosts || echo '$IP_W2 already present'
    ! grep -q '^$IP_W3' /etc/hosts && echo '$IP_W3   $ADDRESS_W3' >> /etc/hosts || echo '$IP_W3 already present'

    cat /etc/hosts

  "

done