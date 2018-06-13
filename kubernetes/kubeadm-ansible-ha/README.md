# ansible-kubeadm-ha

Simple experiment on creation of a high availability Kubernetes cluster, made with kubeadm.
This experiment has not been tested extensively, and only on Ubuntu 16.04LTS. 

## Usage 

Edit inventory:

    $ cp inventory.cfg.example inventory.cfg
    $ vim inventory.cfg
    
Edit vars:    

    $ vim vars.yaml
    
Launch playbook:

    $ ansible-playbook -i inventory.cfg bootstrap-cluster.yaml    


## TODO

- when configuration change, trigger services restart (etcd, keepalived, ...)
- replace restart with start (etcd, keepalived, ...)
- etcd doit utiliser tls
- scale flannel ?
- check kube-proxy is scaled enought on every hosts
- scale dashboard and verify others components
- investigate labels in order to affect each component to a master
- setup flannel one first then duplicate ?