# Helm, gestionnaire de paquet k8s

Installation:

    $ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash 
    $ helm init
    
Lister les installations existantes:

    $ 😞 helm list 
    NAME                    REVISION        UPDATED                         STATUS          CHART                   NAMESPACE
    independent-beetle      1               Tue Sep 19 16:28:01 2017        DEPLOYED        prometheus-4.5.0        default  
    looping-puma            1               Tue Sep 19 16:29:30 2017        DEPLOYED        sonatype-nexus-0.1.0    default  
        
Supprimer un déploiement:

    $ helm delete --purge looping-puma  