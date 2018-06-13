# Installer Kubernetes avec conjure-up et juju

Voir: https://jujucharms.com/canonical-kubernetes/
      https://jujucharms.com/docs/stable/getting-started

## Définitions

- **conjure-up** est un outil d'installation de logiciels complexes, à l'aide de 'recettes'.
- **juju** est un outil de gestion de cloud.

## Préparation

Installer conjure-up. 

    $ sudo snap install conjure-up --classic

Enregistrer le cloud au préalable:

    $ vim myvscloud.yaml           
    
    ---
    clouds:
     myvscloud:
      type: vsphere
      auth-types: [userpass]
      endpoint: 10.0.7.16       # adresse ip du vcenter
      regions:
       cloudlab: {}

    $ juju add-cloud myvscloud myvscloud.yaml
    
    $ juju list-clouds
   
    $ juju add-credential myvscloud 
   
       Enter credential name: credential1
       
       Using auth-type "userpass".
       
       Enter user: root
       
       Enter password: 
       
       Credentials added for cloud myvscloud.
    
    $ juju list-credentials
    
    $ juju set-default-credential myvscloud credential1
    
    $ juju bootstrap myvscloud myvscontroller
    
    Creating Juju controller "myvscontroller" on myvscloud/cloudlab
    Looking for packaged Juju agent version 2.2.1 for amd64
    Launching controller instance(s) on myvscloud/cloudlab...
     - juju-31bcda-0 (arch=amd64 mem=3.5G) mg.vmdk: 63.21% (42.2MiB/s)ases/xenial/release-20170815.1/ubuntu-16.04-server-cloudimg-amd64.ova
    Fetching Juju GUI 2.8.0
    Waiting for address
    Attempting to connect to 10.0.2.7:22
    Attempting to connect to fe80::250:56ff:feb4:c0e:22
    Bootstrap agent now started
    Contacting Juju controller at 10.0.2.7 to verify accessibility...
    Bootstrap complete, "myvscontroller" controller now available.
    Controller machines are in the "controller" model.
    Initial model "default" added.


## Installation d'un cluster kubernetes

Lancer conjure-up:

    $ conjure-up

Sélectionner:

    Kubernetes ubuntu distribution
    myvscloud
    credential1 
    
En cas d'erreurs un journal est disponible ici:

    $ cat ~/.cache/conjure-up/conjure-up.log   

A la fin de l'installation, modifier eventuellement la configuration:

    $ cd ~/.kube
    $ cp config.conjure-canonical-kubern-2af config 
    
Vérifier l'état du cluster:

    $ kubectl cluster-info     

## Utilisation

Différentes interfaces web sont disponibles aux adresses suivantes:

    $ kubectl cluster-info

Le mot de passe par défaut admin est disponible dans la config:

    $ cat ~/.kube/config
    
    users:
    - name: admin
      user:
        password: ****************************
        username: admin
        
Une interface juju est disponible à l'aide de la commande:

    $ juju gui        
    
Liste des commandes CLI disponibles:

    $ juju help commands 

## Utiliser un cluster existant

Pour utiliser un cluster existant, copier la configuration du poste où le contrôleur a été créé (~/.local/share/juju)

Sauvegarde de configuration:

    $ cd ~
    $ tar -cpzf juju-client-$(date "+%Y%m%d-%H%M%S").tar.gz .local/share/juju 

Voir: https://jujucharms.com/docs/2.1/controllers-backup

Ou créer un autre contrôleur (qui créera une nouvelle machine virtuelle)

### Créer un cotnrôleur

Installer juju:

    $ sudo add-apt-repository --update ppa:juju/stable
    $ sudo apt install juju

Créer un controlleur:

    $ vim myvscloud.yaml           
    
    ---
    clouds:
     myvscloud:
      type: vsphere
      auth-types: [userpass]
      endpoint: 10.0.7.16       # adresse ip du vcenter
      regions:
       cloudlab: {}

    $ juju add-cloud myvscloud myvscloud.yaml
   
    $ juju add-credential myvscloud 
   
       Enter credential name: credential1
       
       Using auth-type "userpass".
       
       Enter user: root
       
       Enter password: ******   # mot de passe du vsphere
       
       Credentials added for cloud myvscloud.
    
    $ juju list-credentials
    
    $ juju set-default-credential myvscloud credential1
    
    $ juju bootstrap myvscloud myvscontroller

Ouvrir l'inteface web:

    $ juju gui
    
Pour utiliser kubectl:

    $ cd ~/.kube
    $ cp config.conjure-canonical-kubern-2af config 
    
## Divers

Créer un contrôlleur créé une machine virtuelle sur le cloud.
Les opérations semblent être éffectuées à partir de cette machine.

Il est possible de modifier les caractéristiques des machines avec des contraintes:
https://jujucharms.com/docs/1.25/reference-constraints

