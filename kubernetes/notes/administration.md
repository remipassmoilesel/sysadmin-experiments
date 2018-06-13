# Administration d'un cluster Kubernetes

## Ressources matérielles

Les namespaces permettent de séparer les régles d'utilisation de ressources matérielles.

    $ kubectl create namespace default-mem-example
    
Voir les ressources allouées à un pod:

    $ kubectl get pod default-mem-demo --output=yaml --namespace=default-mem-example
    
    containers:
    - image: nginx
      imagePullPolicy: Always
      name: default-mem-demo-ctr
      resources:
        limits:
          memory: 512Mi
        requests:
          memory: 256Mi