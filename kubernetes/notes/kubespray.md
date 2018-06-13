# Kubespray

## Kubespray-cli

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

## A explorer

Création d'un fichier index.html dans le dossier root, comme si une ressource téléchargée n'avait pas de chemin de destination.
Première création sur debian: le serveur ne redémarre pas ?
