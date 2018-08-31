# Préparation d'un template Ubuntu 18 pour Terraform et cloud-init

    $ sudo apt install cloud-init
    $ vim /etc/cloud/cloud.cfg.d/90_dpkg.cfg
    
    datasource_list: [ None ]
