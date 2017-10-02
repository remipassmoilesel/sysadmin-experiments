# Cluster KeyCloak

Source: http://blog.keycloak.org/2015/04/running-keycloak-cluster-with-docker.html

Nécéssite Docker.

## Lancer Postgres

Créer un conteneur et lancer Postgres:

    $ ./1-postgres.sh
    
Vérifier que la base de données keycloak est crée:    
    
    $ docker inspect -f '{{ .NetworkSettings.IPAddress }}' postgres
    $ psql -U keycloak -h 172.17.0.2  
    $ \l
    
## Lancer deux instances de KeyCloak

    $ 2-keycloak1.sh
    $ 3-keycloak2.sh

    