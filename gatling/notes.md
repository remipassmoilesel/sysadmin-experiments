# Tests de charge Gatling

## Création d'un projet à partir d'un template

Avec Maven:

    $ mvn archetype:generate 
    
    Rechercher Gatling, puis suivre les instructions
    
    
## Commandes utiles

    $ mvn gatling:test    
    $ mvn gatling:recorder
    
    
## Enregistrer un test

Lancer le recorder:

    $ mvn gatling:recorder
    

Paramétrer le cadre "Simulation informations".                

Lancer chromium:

    $ chromium-browser --proxy-server='localhost:8000'
