# Préparation d'un template Ubuntu 18 pour Terraform et cloud-init

Installer et configure cloud init:

    $ sudo apt install cloud-init
    $ vim /etc/cloud/cloud.cfg.d/90_dpkg.cfg
    
    datasource_list: [ None ]
    

Effacer les données cloud-init:

    $  ( cd /var/lib/cloud/ && sudo rm -rf * )  
    

Créer un fichier de configuration réseau netplan temporaire pour que Terraform puisse contacter la VM au bootstrap:

    $ vim /etc/netplan/network.yaml
    
    network:
        ethernets:
            ens160:
                addresses:
                - 192.168.0.10/24
                dhcp4: false
                gateway4: 192.168.0.1
                nameservers:
                    addresses:
                    - 192.168.0.50
                    search: []
        version: 2
    

Vérifier qu'aucun autre fichier ne peut perturber la configuration réseau (/etc/netplan, etc ...)