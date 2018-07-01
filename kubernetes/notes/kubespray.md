# Kubespray

Kubespray est une bonne solution pour monter un cluster HA. Cependant, kubeadm semble plus stable et 
référencé dans la documentation officielle.

## Kubespray-cli

/!\ Kubespray cli a été déprécié

Installation:

    $ sudo pip install kubespray
    
Création d'un déploiement (commande à confirmer):

    $ kubespray prepare --nodes "node1[ansible_ssh_host=10.99.21.1] \
              node2[ansible_ssh_host=10.99.21.2] node3[ansible_ssh_host=10.99.21.3]" --etcds N+ --masters N+    

Kubespray cli clone le repo kubespray master dans `~/.kubespray`

Editer le fichier d'inventaires:

    $ vim ~/.kubespray/inventory/inventory.cfg

Déployer:

    $ kubespray deploy

## Interfaces disponibles

cAdvisor:

    http://10.0.2.201:4194

API rest:

    https://10.0.2.201:6443     root   changeme

## Problèmes courants

**Réinstallation (01/07/2018)**: après une première installation, les suivantes peuvent échouer (api server non stable, etc ...)
Supprimer le dossier /etc/kubernetes de tous les noeuds peut arranger ce problème.

## A explorer

Création d'un fichier index.html dans le dossier root, comme si une ressource téléchargée n'avait pas de chemin de destination.
Première création sur debian: le serveur ne redémarre pas ?
