# Notes générales sur Ansible

Ansible est un outil de déploiement qui utilise SSH et qui ne nécéssite pas de daemon sur les 
systèmes cibles.

Le système cible nécéssite Python.

## Installation 

Sur système cible Ubuntu:

    $ sudo apt install python openssh
    
Sur système hôte Ubuntu:

    $ sudo apt install python openssh
    $ pip install pip --upgrade
    $ pip install ansible
    
/!\ Ne pas utiliser les paquets Ubuntu/Debian, ils sont trop anciens

Les l'hôte doit être enregistré auprès du système cible:

    $ ssh-copy-id -f ~/.ssh/id_rsa  ansible@target.domain.com
    

## Fichiers de configuration

    /etc/ansible/hosts
    /etc/ansible/ansible.cfg

### /etc/ansible/ansible.cfg: configuration générale

Désactiver la vérification d'hôtes SSH, utile selon la doc officielle pour
  éviter des erreurs dans les scripts. Attention, peut représenter un risque.

    [defaults]
    host_key_checking = False

## Droits utilisateurs

La doc d'Ansible recommande que l'utilisateur de la machine cible n'ai pas à utiliser 
de commande d'élevation de privilèges (sudo, etc..). Il doit avoir les droits utiles à 
ses tâches. Cela évite également la gestion et les prompts de mots de passe.

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    