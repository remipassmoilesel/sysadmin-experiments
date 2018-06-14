# Gluster FS

Voir:
 
- https://www.morot.fr/un-systeme-de-fichiers-haute-disponibilite-avec-glusterfs-paru-dans-glmf-144/
- https://linuxfr.org/wiki/glusterfs-sur-ubuntu-debian

## Installation

Le paquet attr permet l'utilisation de droits étendus:

    $ sudo apt install glusterfs-server attr 
   
Découverte de paires:

    $ gluster peer probe 10.0.1.31
    
Lé découverte doit s'éxécuter uniquement à partir d'un noeud.    