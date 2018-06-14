# Exemples de volumes persistents Kubernetes

Un volume est déclaré par un administrateur, et réclamé par un utilisateur avec un volume claim.

Chaque volume est associé à un seul claim, mais le claim peut être partagé entre plusieurs pods.

## Faire tourner l'exemple

Installer puis démarrer minikube:

    $ minikube start 
    $ minikube dashboard

Un serveur NFS doit tourner:
    
    $ cd sysadmin-experiments/nfs
    $ vagrant up
    
Construire et déployer:

    $ ./minikube-deploy.sh
    
         