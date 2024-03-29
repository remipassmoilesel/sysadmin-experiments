#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/04-etcd.md

for host in controller0 controller1 controller2; do

    echo "Connection to ${host}"

    gcloud compute ssh ${host} --command "
        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        INTERNAL_IP=\$(curl -s -H 'Metadata-Flavor: Google' \
            http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)

        ETCD_NAME=controller\$(echo \$INTERNAL_IP | cut -c 11)

        echo Internal IP=\$INTERNAL_IP Etcd Name=\$ETCD_NAME

        # create etcd directory
        sudo mkdir -p /etc/etcd/

        # copy keys
        cd ~
        sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/

        # download and extract etcd
        wget https://github.com/coreos/etcd/releases/download/v3.1.4/etcd-v3.1.4-linux-amd64.tar.gz
        tar -xvf etcd-v3.1.4-linux-amd64.tar.gz

        # move to etcd and etcdctl to bin dir
        sudo mv etcd-v3.1.4-linux-amd64/etcd* /usr/bin/

        # create a folder for datas
        sudo mkdir -p /var/lib/etcd

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
  --initial-cluster controller0=https://10.240.0.10:2380,controller1=https://10.240.0.11:2380,controller2=https://10.240.0.12:2380 \\\\
  --initial-cluster-state new \\\\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move service file and start etcd
        sudo mv etcd.service /etc/systemd/system/
        sudo systemctl daemon-reload
        sudo systemctl enable etcd
        sudo systemctl start etcd
        sudo systemctl status etcd --no-pager

    "

done
