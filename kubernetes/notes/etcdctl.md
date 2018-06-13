# Etcdctl

Utilisation la plus simple:

    $ docker exec -ti etcd1 ash
    $ etcdctl members list

Installation sur un cluster kubespray:

    $ docker cp etcd1:/usr/local/bin/etcdctl /usr/local/bin
    
Localiser les clefs:

    $ docker exec -ti etcd1 env
        
Ensuite, si on utilise l'api v3:

    #!/usr/bin/env bash
    
    # see https://github.com/coreos/etcd/blob/master/etcdctl/README.md
    
    export ETCDCTL_API=3
    export ETCDCTL_DIAL_TIMEOUT=3s
    export ETCDCTL_CACERT=/tmp/ca.pem
    export ETCDCTL_CERT=/tmp/cert.pem
    export ETCDCTL_KEY=/tmp/key.pem

    export ETCDCTL_ENDPOINT=https://localhost:2379
    
    etcdctl member list