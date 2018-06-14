# Gluster FS

Voir:
 
- https://www.morot.fr/un-systeme-de-fichiers-haute-disponibilite-avec-glusterfs-paru-dans-glmf-144/
- https://linuxfr.org/wiki/glusterfs-sur-ubuntu-debian

## Installation

Le paquet attr permet l'utilisation de droits étendus:

    $ sudo apt install glusterfs-server attr 
   
Découverte de paires:

    $ gluster peer probe 10.0.1.31
    
Le découverte doit s'éxécuter uniquement à partir d'un noeud.    

Statut du cluster:

    $ gluster peer status
    
## Création d'un volume répliqué    
    
Création d'un volume répliqué entre trois instances:

    $ gluster volume create repl-vol replica 3 transport tcp \
        10.0.1.30:/data/volume0/brick0/ \
        10.0.1.31:/data/volume0/brick0 \
        10.0.1.32:/data/volume0/brick0 force

Il est recommandé de placer les données dans un sous dossier du point de montage. Par exemple pour:

    $ sudo mount /dev/sda1 /data/volume0
    -> les données doivent se trouver dans /data/volume0/brick0
        
Le flag force en find de commande peut être utilisé si les données sont sur la partition root, 
ce qui est déprécié. Utiliser une partition séparée avec LVM.

    $ gluster volume start repl-vol        
    
    
/!\ La création de fichiers sur le colume directement ne provoque pas de réplication !
    
    