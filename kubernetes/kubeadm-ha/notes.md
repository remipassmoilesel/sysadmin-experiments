# Transformer un cluster non HA en HA

Voir: https://github.com/cookeem/kubeadm-ha/

Structure utilisée dans la documentation:

    k8s-master1	      192.168.60.71	        master node 1	keepalived, nginx, etcd, kubelet, kube-apiserver, kube-scheduler, kube-proxy, kube-dashboard, heapster
    k8s-master2	      192.168.60.72	        master node 2	keepalived, nginx, etcd, kubelet, kube-apiserver, kube-scheduler, kube-proxy, kube-dashboard, heapster
    k8s-master3	      192.168.60.73	        master node 3	keepalived, nginx, etcd, kubelet, kube-apiserver, kube-scheduler, kube-proxy, kube-dashboard, heapster
    N/A	              192.168.60.80	        keepalived virtual IP	N/A
    k8s-node1 ~ 8	    192.168.60.81 ~ 88	  8 worker nodes	kubelet, kube-proxy

Structure utilisée dans le cluster d'essai:

    master1     10.0.2.201
    master2     10.0.2.211
    master3     10.0.2.212
    
    virtual ip  10.0.2.202
       
    node1       10.0.2.213   
    node2       10.0.4.101         