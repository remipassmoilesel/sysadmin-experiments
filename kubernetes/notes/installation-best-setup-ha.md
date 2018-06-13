# Composants pour installation en haute disponibilité

Composants:

    Kubespray 2.2.0/ 
    3 ETCD séparés
    3 Controller
    n Workers
    
Exemple d'inventaire:

    [kube-master]
    10.0.5.10
    10.0.5.11
    10.0.5.12
    
    [etcd]
    10.0.5.20
    10.0.5.21
    10.0.5.22
    
    [kube-node]
    10.0.5.30
    10.0.5.31
    
    [k8s-cluster:children]
    kube-node
    kube-master
    
    [all:vars]
    ansible_user=root
    
Les machines ETCD doivent être suffisament bien dimensionnée et fonctionner avec un **disque SSD**.

Les nodes kubernetes **ne doivent pas utiliser de swap**.