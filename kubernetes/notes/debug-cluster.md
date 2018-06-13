# Debugger un cluster

Vérifier que tous les noeuds soient ready:

    $ kubectl cluster-info 
    $ kubectl cluster-info dump
    $ kubectl get componentstatuses
    $ kubectl get nodes
    $ kubectl get pods -n kube-system
    
Journaux (pas forcement à ces emplacements):

    Master
    /var/log/kube-apiserver.log - API Server, responsible for serving the API
    /var/log/kube-scheduler.log - Scheduler, responsible for making scheduling decisions
    /var/log/kube-controller-manager.log - Controller that manages replication controllers
    
    Worker Nodes
    /var/log/kubelet.log - Kubelet, responsible for running containers on the node
    /var/log/kube-proxy.log - Kube Proxy, responsible for service load balancing
    
Ou, si les services sont déployés en tant que pods:

    $ kubectl get pods -n kube-system 
    $ kubectl logs kube-dns-3097350089-v6wl0 kubedns -n kube-system     
    
Inspecter l'ETCD:
    
    $ etcdctl --endpoints https://10.0.4.105:2379 ls /calico --recursive | less
    $ etcdctl  --endpoints https://10.0.4.105:2379  ls --recursive -p | grep -v '/$' | \
          xargs -n 1 -I% sh -c 'echo -n %:; etcdctl  --endpoints https://10.0.4.105:2379 get %;' > etcd-dump.txt
          
Afficher les membres et l'état du cluster:
          
    # /usr/local/bin/etcdctl --peers=https://10.0.5.20:2379,https://10.0.5.21:2379,https://10.0.5.22:2379 cluster-health 
    
    member 31b74c5ff1206a78 is healthy: got healthy result from https://10.0.5.21:2379
    failed to check the health of member a25dc3c1de8aaa78 on https://10.0.5.20:2379: Get https://10.0.5.20:2379/health: dial tcp 10.0.5.20:2379: i/o timeout
    member a25dc3c1de8aaa78 is unreachable: [https://10.0.5.20:2379] are all unreachable
    member bd28c6afc164cd86 is healthy: got healthy result from https://10.0.5.22:2379
    cluster is healthy
    
    # /usr/local/bin/etcdctl --peers=https://10.0.5.20:2379,https://10.0.5.21:2379,https://10.0.5.22:2379 member list

    31b74c5ff1206a78: name=etcd2 peerURLs=https://10.0.5.21:2380 clientURLs=https://10.0.5.21:2379 isLeader=true
    a25dc3c1de8aaa78: name=etcd1 peerURLs=https://10.0.5.20:2380 clientURLs=https://10.0.5.20:2379 isLeader=false
    bd28c6afc164cd86: name=etcd3 peerURLs=https://10.0.5.22:2380 clientURLs=https://10.0.5.22:2379 isLeader=false
           
Ressources:

    Voir https://github.com/kubernetes/kubernetes/wiki/Debugging-FAQ                          

Exemple de déploiement Nginx:

    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 5 # tells deployment to run 2 pods matching the template
      template: # create pods using pod definition in this template
        metadata:
          # unlike pod-nginx.yaml, the name is not included in the meta data as a unique name is
          # generated from the deployment name
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx:1.7.9
            ports:
            - containerPort: 80
