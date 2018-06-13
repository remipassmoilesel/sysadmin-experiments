#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-controller.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3"; do

    echo "Connection to ${host}"

    ssh root@${host} "
        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        # create master directory
        mkdir -p /var/lib/kubernetes/

        # download kubernetes
        wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kube-apiserver -q
        wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kube-controller-manager -q
        wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kube-scheduler -q
        wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl -q

        # install binaries
        chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
        mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/bin/

        # create system file for kube-api
        INTERNAL_IP=\$(ifconfig | grep -Eo 'inet (adr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

        cat > kube-apiserver.service <<EOF
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-apiserver \\\\
  --admission-control=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \\\\
  --advertise-address=\${INTERNAL_IP} \\\\
  --allow-privileged=true \\\\
  --anonymous-auth
  --apiserver-count=3 \\\\
  --audit-log-maxage=30 \\\\
  --audit-log-maxbackup=3 \\\\
  --audit-log-maxsize=100 \\\\
  --audit-log-path=/var/lib/audit.log \\\\
  --bind-address=0.0.0.0 \\\\
  --enable-swagger-ui=true \\\\
  --etcd-servers=http://10.240.0.10:2379,http://10.240.0.11:2379,http://10.240.0.12:2379 \\\\
  --event-ttl=1h \\\\
  --insecure-bind-address=0.0.0.0 \\\\
  --kubelet-https=false \\\\
  --service-cluster-ip-range=${CLUSTER_IP_RANGE} \\\\
  --service-node-port-range=30000-32767 \\\\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move and enable service
         mv kube-apiserver.service /etc/systemd/system/
         systemctl daemon-reload
         systemctl enable kube-apiserver
         systemctl start kube-apiserver
         systemctl status kube-apiserver --no-pager

        # create file for k8s controller manager

        cat > kube-controller-manager.service <<EOF
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-controller-manager \\\\
  --address=0.0.0.0 \\\\
  --allocate-node-cidrs=true \\\\
  --cluster-cidr=${CLUSTER_CIDR} \\\\
  --cluster-name=kubernetes \\\\
  --leader-elect=true \\\\
  --master=http://\${INTERNAL_IP}:8080 \\\\
  --service-cluster-ip-range=${CLUSTER_IP_RANGE} \\\\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # enable service
         mv kube-controller-manager.service /etc/systemd/system/
         systemctl daemon-reload
         systemctl enable kube-controller-manager
         systemctl start kube-controller-manager
         systemctl status kube-controller-manager --no-pager

        # create service for scheduler
        cat > kube-scheduler.service <<EOF
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-scheduler \\\\
  --leader-elect=true \\\\
  --master=http://\${INTERNAL_IP}:8080 \\\\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move and enable service
         mv kube-scheduler.service /etc/systemd/system/
         systemctl daemon-reload
         systemctl enable kube-scheduler
         systemctl start kube-scheduler
         systemctl status kube-scheduler --no-pager

    "




done