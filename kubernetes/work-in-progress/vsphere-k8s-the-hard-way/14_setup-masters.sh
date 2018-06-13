#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-controller.md

set -x
source config.sh

for host in  "$IP_M1" "$IP_M2" "$IP_M3"; do

    echo "Connection to ${host}"

    ssh root@${host} "

        set -x

        echo \"Commands executed on bash by \$USER@\$HOSTNAME\"

        # create master directory
         mkdir -p /var/lib/kubernetes/

        # move token and keys
        cd ~
         mv token.csv /var/lib/kubernetes/
         mv ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem /var/lib/kubernetes/

        # download kubernetes
        if [ $DOWNLOAD_DEPENDENCIES = true ]; then
          wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kube-apiserver -q
          wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kube-controller-manager -q
          wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kube-scheduler -q
          wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl -q
        fi

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
  --apiserver-count=3 \\\\
  --audit-log-maxage=30 \\\\
  --audit-log-maxbackup=3 \\\\
  --audit-log-maxsize=100 \\\\
  --audit-log-path=/var/lib/audit.log \\\\
  --authorization-mode=RBAC \\\\
  --bind-address=0.0.0.0 \\\\
  --client-ca-file=/var/lib/kubernetes/ca.pem \\\\
  --enable-swagger-ui=true \\\\
  --etcd-cafile=/var/lib/kubernetes/ca.pem \\\\
  --etcd-certfile=/var/lib/kubernetes/kubernetes.pem \\\\
  --etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \\\\
  --etcd-servers=https://${IP_M1}:2379,https://${IP_M2}:2379,https://${IP_M3}:2379 \\\\
  --event-ttl=1h \\\\
  --experimental-bootstrap-token-auth \\\\
  --insecure-bind-address=0.0.0.0 \\\\
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \\\\
  --kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \\\\
  --kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem \\\\
  --kubelet-https=true \\\\
  --runtime-config=rbac.authorization.k8s.io/v1alpha1 \\\\
  --service-account-key-file=/var/lib/kubernetes/ca-key.pem \\\\
  --service-cluster-ip-range=${CLUSTER_SERVICE_IP_RANGE} \\\\
  --service-node-port-range=30000-32767 \\\\
  --tls-cert-file=/var/lib/kubernetes/kubernetes.pem \\\\
  --tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem \\\\
  --token-auth-file=/var/lib/kubernetes/token.csv \\\\
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
  --cluster-signing-cert-file=/var/lib/kubernetes/ca.pem \\\\
  --cluster-signing-key-file=/var/lib/kubernetes/ca-key.pem \\\\
  --leader-elect=true \\\\
  --master=http://\${INTERNAL_IP}:8080 \\\\
  --root-ca-file=/var/lib/kubernetes/ca.pem \\\\
  --service-account-private-key-file=/var/lib/kubernetes/ca-key.pem \\\\
  --service-cluster-ip-range=${CLUSTER_SERVICE_IP_RANGE} \\\\
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