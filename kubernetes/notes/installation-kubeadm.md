# Installation de Kubernetes avec kubeadm et création d'un cluster

## Principales commandes

Annuler les modifications faites:

    $ kubeadm reset
    
Liste des tokens valides:

    $ kubeadm token list
    
Joindre des esclaves:    
    
    $ kubeadm join --token ${TOKEN} ${VIRTUAL_IP}:8443

## Limitations de kubeadm

Pas de High Availability, un seul master.

## Installation 

Mettre à jour le système:

    $ sudo apt-get update && sudo apt-get upgrade
    
Installer docker:

    $ sudo apt install docker.io
    $ sudo usermod -aG docker remipassmoilesel    
    
Installer kubectl:

    $ cd /usr/bin/ \
      && sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
      && sudo chmod +x /usr/bin/kubectl
  
Ajouter le dépôt k8s et installer sur chaque machine:

- docker (paquet docker.io, les dernières versions de Docker ne sont pas supportées)
- kubeadm
- kubectl
- kubelet  
    
## Ajout du dépôt APT kubernetes sur toutes les nodes (master, workers)
    
Installer kubelet, un composant qui doit s'éxecuter sur toutes les machines du cluster,
ainsi que kubeadm, le composant qui démarre le cluster:

    $ sudo apt-get update && sudo apt-get install -y apt-transport-https
    $ sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    $ sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee "/etc/apt/sources.list.d/kubernetes.list" 

Installer sur chaque machine:

- docker (paquet docker.io, les dernières versions de Docker ne sont pas supportées)
- kubeadm
- kubectl
- kubelet

## Initialisation du master

Ensuite entrer la commande:
  
    $ kubeadm init

    [kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
    [init] Using Kubernetes version: v1.7.4
    [init] Using Authorization modes: [Node RBAC]
    [preflight] Running pre-flight checks
    [kubeadm] WARNING: starting in 1.8, tokens expire after 24 hours by default (if you require a non-expiring token use --token-ttl 0)
    [certificates] Generated CA certificate and key.
    [certificates] Generated API server certificate and key.
    [certificates] API Server serving cert is signed for DNS names [ubuntu16-k3-master1.kubernetes kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 10.0.2.201]
    [certificates] Generated API server kubelet client certificate and key.
    [certificates] Generated service account token signing key and public key.
    [certificates] Generated front-proxy CA certificate and key.
    [certificates] Generated front-proxy client certificate and key.
    [certificates] Valid certificates and keys now exist in "/etc/kubernetes/pki"
    [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/scheduler.conf"
    [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/admin.conf"
    [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/kubelet.conf"
    [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/controller-manager.conf"
    [apiclient] Created API client, waiting for the control plane to become ready
    [apiclient] All control plane components are healthy after 46.501021 seconds
    [token] Using token: 8d0f33.442ba0dd12ebd94f
    [apiconfig] Created RBAC rules
    [addons] Applied essential addon: kube-proxy
    [addons] Applied essential addon: kube-dns
    
    Your Kubernetes master has initialized successfully!
    
    To start using your cluster, you need to run (as a regular user):
    
      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config
    
    You should now deploy a pod network to the cluster.
    Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
      http://kubernetes.io/docs/admin/addons/
    
    You can now join any number of machines by running the following on each node
    as root:
    
      kubeadm join --token 8d0f33.442ba0dd12ebd94f 10.0.2.201:6443


Garder le token.

## Initialisation des workers

Entrer la commande:
  
    $ kubeadm join --token 8d0f33.442ba0dd12ebd94f 10.0.2.201:6443
    
## Finalisation

Créer un réseau de pod avant l'installation de toute autre application.
Exemple avec flannel:

    $ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml \
        && kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml
    
Récupérer sur son poste les réglages permettant d'utiliser kubectl:

    $ scp root@<master ip>:/etc/kubernetes/admin.conf .
    $ kubectl --kubeconfig ./admin.conf get nodes
    
Déployer une application:

    $ kubectl --kubeconfig admin.conf create namespace sock-shop
    $ kubectl --kubeconfig admin.conf apply -n sock-shop -f "https://github.com/microservices-demo/microservices-demo/blob/master/deploy/kubernetes/complete-demo.yaml?raw=true"
    
 