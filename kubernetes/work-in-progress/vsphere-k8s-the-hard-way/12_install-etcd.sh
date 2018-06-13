#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3"; do

    echo "Connection to ${host}"

    ssh root@${host}  "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        INTERNAL_IP=\$(ifconfig | grep -Eo 'inet (adr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

        ETCD_NAME=controller\$(echo \$INTERNAL_IP | cut -c 10)

        echo Internal IP=\$INTERNAL_IP Etcd Name=\$ETCD_NAME

        # create etcd directory
        mkdir -p /etc/etcd/

        # copy keys
        cd ~
        cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/

        # download and extract etcd
        if [ $DOWNLOAD_DEPENDENCIES = true ]; then
          wget https://github.com/coreos/etcd/releases/download/v3.1.4/etcd-v3.1.4-linux-amd64.tar.gz -q
        fi

        tar -xf etcd-v3.1.4-linux-amd64.tar.gz

        # move to etcd and etcdctl to bin dir
        mv etcd-v3.1.4-linux-amd64/etcd* /usr/bin/

        # create a folder for datas
        mkdir -p /var/lib/etcd

        # create service file
        cat > etcd.service <<EOF
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/bin/etcd \\\\
  --name \${ETCD_NAME} \\\\
  --cert-file=/etc/etcd/kubernetes.pem \\\\
  --key-file=/etc/etcd/kubernetes-key.pem \\\\
  --peer-cert-file=/etc/etcd/kubernetes.pem \\\\
  --peer-key-file=/etc/etcd/kubernetes-key.pem \\\\
  --trusted-ca-file=/etc/etcd/ca.pem \\\\
  --peer-trusted-ca-file=/etc/etcd/ca.pem \\\\
  --peer-client-cert-auth \\\\
  --client-cert-auth \\\\
  --initial-advertise-peer-urls https://\${INTERNAL_IP}:2380 \\\\
  --listen-peer-urls https://\${INTERNAL_IP}:2380 \\\\
  --listen-client-urls https://\${INTERNAL_IP}:2379,http://127.0.0.1:2379 \\\\
  --advertise-client-urls https://\${INTERNAL_IP}:2379 \\\\
  --initial-cluster-token etcd-cluster-0 \\\\
  --initial-cluster controller0=https://${IP_M1}:2380,controller1=https://${IP_M2}:2380,controller2=https://${IP_M3}:2380 \\\\
  --initial-cluster-state new \\\\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move service file and start etcd
         mv etcd.service /etc/systemd/system/
         systemctl daemon-reload
         systemctl enable etcd
         systemctl restart etcd
         systemctl status etcd --no-pager

    "

done
