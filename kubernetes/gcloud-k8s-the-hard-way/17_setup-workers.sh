#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/06-kubernetes-worker.md

# enable tsl bootstrapping from master
gcloud compute ssh controller0 --command "
    echo 'Commands executed on bash by \$USER@\$host'
    kubectl create clusterrolebinding kubelet-bootstrap \
      --clusterrole=system:node-bootstrapper \
      --user=kubelet-bootstrap
"

for host in worker0 worker1 worker2; do
    echo "Connection to ${host}"

    gcloud compute ssh ${host} --command "
        echo 'Commands executed on bash by \$USER@\$host'

        cd ~

        # create directories for k8s and move config
        sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}
        sudo mkdir -p /var/run/kubernetes
        sudo mv bootstrap.kubeconfig /var/lib/kubelet
        sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy

        # move certificates
        sudo mv ca.pem /var/lib/kubernetes/

        # install docker
        wget https://get.docker.com/builds/Linux/x86_64/docker-1.12.6.tgz
        tar -xvf docker-1.12.6.tgz
        sudo cp docker/docker* /usr/bin/

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
        sudo mv docker.service /etc/systemd/system/docker.service
        sudo systemctl daemon-reload
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo docker version

        # install cni
        sudo mkdir -p /opt/cni
        wget https://storage.googleapis.com/kubernetes-release/network-plugins/cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz
        sudo tar -xvf cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz -C /opt/cni

        # download and install k8s worker binaries
        wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl
        wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kube-proxy
        wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubelet
        chmod +x kubectl kube-proxy kubelet
        sudo mv kubectl kube-proxy kubelet /usr/bin/

        # create k8s workers service
        API_SERVERS=\$(sudo cat /var/lib/kubelet/bootstrap.kubeconfig | \
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
  --cluster-dns=10.32.0.10 \\\\
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
        sudo mv kubelet.service /etc/systemd/system/kubelet.service
        sudo systemctl daemon-reload
        sudo systemctl enable kubelet
        sudo systemctl start kubelet
        sudo systemctl status kubelet --no-pager

        # create kube-proxy service
        cat > kube-proxy.service <<EOF
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-proxy \\\\
  --cluster-cidr=10.200.0.0/16 \\\\
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
        sudo mv kube-proxy.service /etc/systemd/system/kube-proxy.service
        sudo systemctl daemon-reload
        sudo systemctl enable kube-proxy
        sudo systemctl start kube-proxy
        sudo systemctl status kube-proxy --no-pager

    "

done