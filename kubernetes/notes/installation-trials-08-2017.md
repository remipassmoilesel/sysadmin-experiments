# Notes / brouillon

## A explorer

### Installation

**Essayé et réussi:**

- Installation HA "from scratch" sur GCE à l'aide de la doc [kubernetes-the-hard-way](https://github.com/remipassmoilesel/kubernetes-the-hard-way/) 
Les scripts sont disponibles dans le dépot `kubernetes-experiments`
- Installation HA CoreOs/calico mais tous les masters sont marqués comme SchedulingDisabled
- Installation non HA kubespray sur Ubuntu 16 (1 master, 3 slave, réseau Calicot): installation parfaite

**Essayé mais raté:**

- Installation 1.6.8 (latest stable au moment de l'installation) sur cluster ubuntu 16lts "from scratch" (rapide): échec pas de création d'interface réseau
- Installation kubespray sur Debian 9 (1 master, 3 slave, réseau Calicot): l'installation échoue la première fois, réussi la deuxième, et au 
redémarrage kubernetes ne démarre plus
- Installation kubespray sur Ubuntu 16 (3 master, 3 slave, 3 etcd, réseau Calicot): raté 
- Installation kubespray sur Ubuntu 16 (3 master, 3 slave, 1 etcd, réseau Calicot): raté 
- Installation kubespray sur Ubuntu 16 (3 master, 3 slave, 3 etcd, réseau Flannel): raté
- Installation kubespray sur Ubuntu 16 (3 master, 3 slave, 1 etcd, réseau Flannel): raté

**A essayer:**

- Tectonic installer: https://github.com/coreos/tectonic-installer
- Kubespray Ubuntu / Flannel
- Roles ansible galaxy
- Ubuntu from scratch 1.7.4 ()
- Ubuntu snap
- Centos package
- Debian package


### Installation from scratch

- Versions: kubespray, docker > 13 incompatible ? (voir readme)
- downgrade kubernetes pour --configure-cbr0 ?

### Divers

- https://www.tauceti.blog/post/kubernetes-the-not-so-hard-way-with-ansible-at-scaleway-part-1/
- Installation de Prometheus sur Kubernetes: 
https://github.com/kelseyhightower/oscon-2017-kubernetes-tutorial/blob/master/labs/06-tutorial-metrics.md
- Gérer les secrets avec Kubernetes:
https://github.com/kelseyhightower/secrets-controller
- Explorer les dépôt sur k8s https://github.com/kelseyhightower/ (utilisateur expérimenté)  
- Labels k8s: prod preprod dev ?
- YAML pour kubectl
- Si on tu le maitre, les services fonctionnent toujours ?

## Minikube

Démarrage:
	
	$ minikube start
	$ minikube ip
