# Secrets

## Utiliser un secret dans une variable d'environement

      env:
        - name: RABBITMQ_ERLANG_COOKIE
          valueFrom:
           secretKeyRef:
            name: erlang.cookie
            key: erlang.cookie
              
## Secrets pour Docker registry               

Utiliser un Docker registry privé avec authentification

Créer un secret pour le registry:

    DOCKER_REG_ADDRESS=https://docker.bbuzcloud.com/
    DOCKER_REG_USERNAME=user
    DOCKER_REG_PASSWORD=password
    DOCKER_REG_EMAIL=mail@domain.com
    
    $ kubectl create secret docker-registry regsecret \
        --docker-server=$DOCKER_REG_ADDRESS \
        --docker-username=$DOCKER_REG_USERNAME \
        --docker-password=$DOCKER_REG_PASSWORD \
        --docker-email=$DOCKER_REG_EMAIL
        
Afficher le secret:

    $ kubectl get secret regsecret --output=yaml 

Utiliser le secret dans un déploiement:

    apiVersion: v1
    kind: Pod
    metadata:
      name: private-reg
    spec:
      containers:
        - name: private-reg-container
          image: docker.registry.com/health-check-test:1.0
      imagePullSecrets:
        - name: regsecret     # le nom du secret