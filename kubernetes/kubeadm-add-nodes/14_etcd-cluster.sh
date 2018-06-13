#!/usr/bin/env bash

set -x
. ./config.sh

export TEST=false

#TODO: send keys
#TODO: change name of etcds
#TODO: check service file format and location

if [ $TEST = true ]; then
    docker run -p 22:22 -d rastasheep/ubuntu-sshd:16.04
    ssh-keygen -f "/home/remipassmoilesel/.ssh/known_hosts" -R localhost
    ssh-keyscan -H localhost >> ~/.ssh/known_hosts
    ETCD_LIST=(localhost)
fi

ETCD_INITIAL_CLUSTER=""

for host in $ETCD_LIST; do 
    ETCD_INITIAL_CLUSTER="$ETCD_INITIAL_CLUSTER,controller1=https://${host}:2380"
done

echo "Using etcd list: $ETCD_INITIAL_CLUSTER"

for host in $ETCD_LIST; do

    ssh root@${host} "

       apt-get update && apt-get install -y apt-transport-https

        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

        add-apt-repository \"deb https://apt.kubernetes.io/ kubernetes-xenial main\"


        apt-get update
        apt-get install -y etcd
        
        
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
  --initial-cluster $ETCD_INITIAL_CLUSTER \\\\
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