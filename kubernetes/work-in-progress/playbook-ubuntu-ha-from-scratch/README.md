# Playbook d'installation de cluster HA

## Objectif 
Créer un cluster Kubernetes High Availability.

Le cluster sera composé de:
- maitres: (au moins trois) sur lesquels seront installé ETCD et qui controlleront le cluster
- travailleurs: sur lesquels les applications s'éxécuteront 

Le cluster utilise des adresses IP statiques routables.

## Inventaire

Nécéssite un inventaire de la forme suivante:

    [masters]
    10.0.4.101 ansible_user=root
    10.0.4.102 ansible_user=root
    10.0.4.103 ansible_user=root
        
    
    [workers]
    10.0.4.111 ansible_user=root
    10.0.4.112 ansible_user=root
    10.0.4.113 ansible_user=root
    
    [all:childrens]
    masters
    workers