# Attacher un pod à un node

Lister les nodes:

    $ 😞 kubectl get nodes   
    NAME                  STATUS    AGE       VERSION
    debian9-k12-master1   Ready     4d        v1.7.3+coreos.0
    debian9-k12-master2   Ready     4d        v1.7.3+coreos.0
    debian9-k12-master3   Ready     4d        v1.7.3+coreos.0
    debian9-k12-node1     Ready     4d        v1.7.3+coreos.0
    debian9-k12-node2     Ready     4d        v1.7.3+coreos.0
    debian9-k12-node3     Ready     4d        v1.7.3+coreos.0

Pour afficher les labels existants d'une machine:

    $ kubectl get nodes --show-labels
    $ kubectl describe node debian9-k12-master1 

Ajouter un label aux nodes concernés:

    $ kubectl label nodes debian9-k12-node1  nginx=true
    $ kubectl label nodes debian9-k12-node2  nginx=true
    $ kubectl label nodes debian9-k12-node3  nginx=true
    
Pour supprimer un label:
    
    $ kubectl label nodes debian9-k12-node1 nginx-
    
Ajouter un label au déploiement:

    metadata:
      labels:
          nginx: true

