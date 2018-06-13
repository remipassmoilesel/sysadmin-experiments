# Vocabulaire et concepts

- **k8s**: Kubernetes
- **Pod**: plus petite unité logique, un ou plusieurs conteneurs. Les pods sont éphémères 
(adresses IP temporaires). Ils partagent le même localhost.
- **Service**: Groupe des services. Fournit une adresse ip durable (virtuelle, interne au cluster), 
et peut assurer le load balancing.
- **Replication controller**: gére la réplication des pods, en créé ou en supprime au besoin
- **Replica set**: nouveau controlleur de réplication, permet d'utiliser des labels pour les manipulation

## Composants

Voir: https://kubernetes.io/docs/concepts/overview/components/ 

- **Etcd**: Magasin clefs/valeurs distribué utilisé pour la coordination des clusters (stocke adresses ip, 
services disponibles, etc ...)
- **Flannel**: outil de transformation des paquets réseau pour router des paquets entre conteneurs distant
coreos: distribution minimale contenant docker, kubernetes, et autres outils pour clusters
- **kubelet**: agent client k8s
- **kubenet**: plugin réseau par défaut, ne créé qu'un interface cbr0 (normalement). Tourne sur tous 
les noeuds d'un cluster.
- **kube-proxy**: permet l'abstraction réseau kubernetes concernant les services et pods en 
faisant du port forwarding, etc ...    Peut permettre du DNS avec kubedns.

## Services

Voir: https://kubernetes.io/docs/concepts/services-networking/service/

Plusieurs types:

- **Cluster IP**: expose un service sur une adresse interne du cluster. Contient une liste de 
'End Points', des pods a contacter pour assurer un service. Type par défaut.
- **Node port**: expose un port lié à un service sur tous les workers. Par exemple si il y a trois 
workers, un service node port 10022 sera disponible sur 10.0.50.1, 10.0.50.2, 10.0.50.3. (même
à l'extérieur du cluster)
- **Load balancer**: exposer un service pour utiliser un balancement de charge fourni par un tiers.
- **ExternalName**: Nécéssite KubeDNS > 1.7, permet d'associer un service avec un nom de domaine.


Un service peut exposer également des ressources non clusterisées comme du BDD de test, etc...
Exemple:

    kind: Endpoints
    apiVersion: v1
    metadata:
      name: my-service
    subsets:
      - addresses:
          - ip: 1.2.3.4
        ports:
          - port: 9376 