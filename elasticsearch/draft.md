# Elasticsearch

Lister tous les index:

    $ http://host:9200/_cat/indices?v
    
Lancer un conteneur Docker en local:

    $ docker run -e "ES_JAVA_OPTS=-Xms256m -Xmx256m" -p 9200:9200 -p 9300:9300 docker.elastic.co/elasticsearch/elasticsearch:6.3.2


## Vérifier le nom et la santé d'un cluster

    $ curl host:9200/_cluster/health | jq
    $ curl host:9200/_cluster/state | jq
    $ curl "host:9200/_cat/nodes?v"


## Poster un document

    PUT localhost:9200/twitter/_doc/1
    
    {
        "user" : "kimchy",
        "post_date" : "2009-11-15T14:12:12",
        "message" : "trying out Elasticsearch"
    }


## Afficher l'état des index

    GET http://host:9200/_cluster/health/?level=shards


## Exporter tous les index / mappings

    $ curl -XGET 'http://localhost:9200/_all'
    
    $ curl -XGET 'http://localhost:9200/_all/_mapping'


## Cas d'erreurs

### [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]:

    $ sudo sysctl -w vm.max_map_count=262144    

    
### o.e.c.t.TransportClientNodesService      : node null not part of the cluster Cluster [elasticsearch], ignoring...

Le nom du cluster elastic search du client n'est pas le bon     
    

### None of the cluster node are available

- Vérifier le nom du cluster.
- Peut être provoqué par l'option "sniffing"

    
    