#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/06-kubernetes-worker.md

set -x
source config.sh

# enable tsl bootstrapping from master
ssh root@"$IP_M1"  "

    set -x

    echo \"Commands executed on bash by \$USER@$host\"

    kubectl create clusterrolebinding kubelet-bootstrap \
      --clusterrole=system:node-bootstrapper \
      --user=kubelet-bootstrap
"

for host in "$IP_W1" "$IP_W2" "$IP_W3"; do
    echo "Connection to ${host}"

    ssh root@${host} "

        set -x

        echo \"Commands executed on bash by \$USER@$host\"

        cd ~

        # create directories for k8s and move config
        mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}
        mkdir -p /var/run/kubernetes
        mv bootstrap.kubeconfig /var/lib/kubelet
        mv kube-proxy.kubeconfig /var/lib/kube-proxy

        # move certificates
         mv ca.pem /var/lib/kubernetes/

        # install docker
        if [ $DOWNLOAD_DEPENDENCIES = true ]; then
          wget https://get.docker.com/builds/Linux/x86_64/docker-1.12.6.tgz -q
        fi

        tar -xf docker-1.12.6.tgz
        cp docker/docker* /usr/bin/

        # create service file for docker
        cat > docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com

[Service]
ExecStart=/usr/bin/docker daemon \\\\
  --iptables=false \\\\
  --ip-masq=false \\\\
  --host=unix:///var/run/docker.sock \\\\
  --log-level=error \\\\
  --storage-driver=overlay
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move and enable service
        mv docker.service /etc/systemd/system/docker.service
        systemctl daemon-reload
        systemctl enable docker
        systemctl start docker
        docker version

        # install cni
        mkdir -p /opt/cni
        if [ $DOWNLOAD_DEPENDENCIES = true ]; then
          wget https://storage.googleapis.com/kubernetes-release/network-plugins/cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz -q
        fi
        tar -xf cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz -C /opt/cni

        # download and install k8s worker binaries
        if [ $DOWNLOAD_DEPENDENCIES = true ]; then
          wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl -q
          wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kube-proxy -q
          wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubelet -q
        fi
        chmod +x kubectl kube-proxy kubelet
        mv kubectl kube-proxy kubelet /usr/bin/

        # create k8s workers service
        API_SERVERS=\$( cat /var/lib/kubelet/bootstrap.kubeconfig | \
            grep server | cut -d ':' -f2,3,4 | tr -d '[:space:]')

        cat > kubelet.service <<EOF
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/kubelet \\\\
  --api-servers=\${API_SERVERS} \\\\
  --allow-privileged=true \\\\
  --cluster-dns=${CLUSTER_DNS} \\\\
  --cluster-domain=cluster.local \\\\
  --container-runtime=docker \\\\
  --experimental-bootstrap-kubeconfig=/var/lib/kubelet/bootstrap.kubeconfig \\\\
  --network-plugin=kubenet \\\\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\\\
  --serialize-image-pulls=false \\\\
  --register-node=true \\\\
  --tls-cert-file=/var/lib/kubelet/kubelet-client.crt \\\\
  --tls-private-key-file=/var/lib/kubelet/kubelet-client.key \\\\
  --cert-dir=/var/lib/kubelet \\\\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move and enable service
        mv kubelet.service /etc/systemd/system/kubelet.service
        systemctl daemon-reload
        systemctl enable kubelet
        systemctl start kubelet
        systemctl status kubelet --no-pager

        # create kube-proxy service
        cat > kube-proxy.service <<EOF
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-proxy \\\\
  --cluster-cidr=${CLUSTER_CIDR} \\\\
  --masquerade-all=true \\\\
  --kubeconfig=/var/lib/kube-proxy/kube-proxy.kubeconfig \\\\
  --proxy-mode=iptables \\\\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        # move and enable service
        mv kube-proxy.service /etc/systemd/system/kube-proxy.service
        systemctl daemon-reload
        systemctl enable kube-proxy
        systemctl start kube-proxy
        systemctl status kube-proxy --no-pager

    "

done