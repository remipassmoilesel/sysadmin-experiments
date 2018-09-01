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


## Boot Stages

Voir: https://cloudinit.readthedocs.io/en/latest/topics/boot.html

Un générateur systemd active ou non les services systemd nécéssaire.

    $ cloud-init-local.service −> Executes cloud-init init --local
    $ cloud-init.service ->  cloud-init init
    $ cloud-config.service -> Executes cloud-init modules --mode=config
    $ cloud-final.service -> Executes cloud-init modules --mode=final
    

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
