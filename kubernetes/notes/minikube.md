# Minikube

Cluster d'expérimentations.

## Principales commandes

    $ minikube start
    $ minikube delete
    $ minikube ssh
    $ minikube dashboard
    
## Construire une image docker sur la VM

    $ eval $(minikube docker-env)
    $ docker build . -t image-name
    
## Elévation de privilèges

    $ su
    
Ou:

    $ sudo command
    
En SSH:

    $ minkube ssh "
        sudo mkdir /mnt/path
        ...
    "

        