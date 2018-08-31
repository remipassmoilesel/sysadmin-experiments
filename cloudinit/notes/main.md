# Cloud init

## Installation sur Ubuntu Server

    $ sudo apt install cloud-init


## Configuration

- Fichier principal: /etc/cloud/cloud.cfg
- Plus dossier: /etc/cloud/cloud.cfg.d

Pour être prises en compte, toutes les configurations doivent commencer par la ligne:

    #cloud-config
    

## Configuration réseau

Voir https://cloudinit.readthedocs.io/en/latest/topics/network-config-format-v2.html#examples


## Statut de cloud init

Voir https://cloudinit.readthedocs.io/en/latest/topics/boot.html

Sur Bionic:
    
    $ sudo systemctl status cloud-init-local


## Journaux

    $ less /var/log/cloud-init.log
    $ less /var/log/cloud-init-output.log
    

## Debug

Lancer cloud init avec log de debug:

    $ ( cd /var/lib/cloud/ && sudo rm -rf * ) && cloud-init -d init
    

## Erreurs

Il peut être nécéssaire de désactiver les sources de donnée si on en a pas besoin:

    $ vim /etc/cloud/cloud.cfg.d/90-dpkg.cfg
    
    datasource_list: [ None ]
