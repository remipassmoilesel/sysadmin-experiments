# Elasticsearch Curator

Pour un nettoyage régulier des données, voir Curator:

    https://www.elastic.co/guide/en/elasticsearch/client/curator/4.0/examples.html

Installation:

    $ vim /etc/apt/sources.list.d/curator
    
    deb http://packages.elastic.co/curator/4/debian stable main
    
    $ sudo apt update
    $ sudo apt install curator

Créer deux fichiers de configuration:

    $ vim curator.yml
    $ vim curator-actions.yml
    
Lancer un nettoyage:    
    
    $ curator /home/user/.curator/curator-actions.yml > /home/user/elastic-search-cleaning.log 2>&1

