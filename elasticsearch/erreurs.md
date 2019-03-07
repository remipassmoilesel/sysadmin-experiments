# Cas d'erreurs

## [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]:

    $ sudo sysctl -w vm.max_map_count=262144    

    
## o.e.c.t.TransportClientNodesService      : node null not part of the cluster Cluster [elasticsearch], ignoring...

Le nom du cluster elastic search du client n'est pas le bon     
    

## None of the cluster node are available

- Vérifier le nom du cluster.
- Peut être provoqué par l'option "sniffing"

