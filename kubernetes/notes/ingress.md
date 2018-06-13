# Kubernetes Ingress

Voir: 
    
    https://github.com/kubernetes/ingress-nginx/blob/master/README.md
    https://github.com/kubernetes/ingress-nginx/blob/master/deploy/README.md#install-without-rbac-roles
    
# Installer une ingress pour le dashboard kubernetes

Cloner le projet charts:    
    
    $ git clone https://github.com/kubernetes/charts 
    $ cd stable/nginx-ingress
    
Ajouter les adresses IP des noeuds du cluster k8s:    
    
    $ vim values.yml
    
    externalIPs:
      - 10.0.0.101
      - 10.0.0.102
      - 10.0.0.103

Installer l'ingress:
    
    $ helm install stable/nginx-ingress --name ingress
    
Configurer le déploiement du dashboard:

    $ cd stable/dashboard      
    
     ingress:
      
       ## If true, Kubernetes Dashboard Ingress will be created.
       ##
       enabled: true

       hosts:
         - kubernetes-dashboard.predev.kubernetes
    
Installer le dashboard:

    $ helm install -f values.yaml stable/kubernetes-dashboard --name=k8s-dashboard 
    
Patcher son fichier /etc/hosts

    $ sudo vim /etc/hosts    
    
    10.0.0.101 kubernetes-dashboard.predev.kubernetes
    
## Erreurs

Ingress non déployé ou ne correspondant à aucun service:

        404 page not found