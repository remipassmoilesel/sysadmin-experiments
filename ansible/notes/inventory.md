# Fichier d'inventaire

## Déclaration

Utiliser celui par défaut dans /etc/ansible/hosts ou le spécifier en ligne de commande:

    $ ansible-playbook -i inventory/cluster.cfg configure-cluster.yaml -b -v
    
## Déterminer le chemin de python sur la cible

Utiliser `ansible_python_interpreter`:
 
    ansible_python_interpreter="/opt/python/bin/python"    
    
## Variables d'hôtes

Il est possible d'utiliser des variables d'hôtes dans les inventaires:

    [cluster]
    10.0.2.101  newAddress=10.0.2.101   newHostname=debian9-k2-master1.kubernetes   ansible_user=root
    10.0.2.111  newAddress=10.0.2.111   newHostname=debian9-k2-node1.kubernetes     ansible_user=root
    
Pour ensuite les utiliser dans des tâches:

    - name: "Configure interfaces"
      include_role:
        name: configure-interfaces
      vars:
        interfaceName: "ens192"
        interfacesPath: "/etc/network/interfaces"
        ipAddress: "{{ newAddress }}"    
        
        
Il est possible d'ajouter des variables par groupes.

## Groupes

Exemples de groupes:
   
    [masters]
    10.0.4.101 ansible_user=root
    10.0.4.102 ansible_user=root
    10.0.4.103 ansible_user=root
        
    
    [workers]
    10.0.4.111 ansible_user=root
    10.0.4.112 ansible_user=root
    10.0.4.113 ansible_user=root

Exemple de groupe de groupes:

    [k8s:childrens]
    masters
    workers        
    
Configuration de groupes:

    [k8s:vars]
    ansible_user=root
    
    