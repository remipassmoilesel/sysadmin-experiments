# Docker

## Container

Exemple: 

    - name: Stop and remove previous etcd container
      docker_container:
        name: etcd
        state: absent
    
    - name: Create etcd container
      docker_container:
        name: etcd
        restart_policy: always
        image: gcr.io/google_containers/etcd-amd64:3.0.17
        published_ports:
          - 4001:4001
          - 2380:2380
          - 2379:2379
        volumes:
          - /var/lib/etcd
          - /etc/ssl/certs
          - /etc/etcd/etcd_start.sh:/etc/etcd/etcd_start.sh
        command:  'sh -c "chmod ugo+x /etc/etcd/etcd_start.sh && /etc/etcd/etcd_start.sh"'
        state:  started
        
/!\ Non fonctionnel, le script est monté comme un dossier !        