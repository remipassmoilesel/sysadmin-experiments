# Liquibase

## Affichage debug

Dans liquibase.properties:

    logLevel=debug
    
Si utilisé avec maven:

    mvn liquibase:update -X
    
## Erreurs possibles

### ERROR: relation "databasechangelog" does not exist

La table est recherchée dans le mauvais schéma. Voir peut être une instruction précédente:

        SET search_path = ...

... qui ne contient pas le schéma voulu.

