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

    $ ./2-keycloak1.sh
    $ ./3-keycloak2.sh

## Administration

    http://127.0.0.1:8080/auth/admin
    http://127.0.0.1:8081/auth/admin
    
## Confirmation de cluster, voir les logs:

    14:01:14,232 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-4) ISPN000094: Received new cluster view for channel hibernate: [node1|1] (2) [node1, node2]
    14:01:14,232 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-8) ISPN000094: Received new cluster view for channel ejb: [node1|1] (2) [node1, node2]
    14:01:14,233 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-8) ISPN000079: Channel ejb local address is node2, physical addresses are [172.17.0.3:55200]
    14:01:14,237 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-4) ISPN000079: Channel hibernate local address is node2, physical addresses are [172.17.0.3:55200]
    14:01:14,240 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-3) ISPN000094: Received new cluster view for channel web: [node1|1] (2) [node1, node2]
    14:01:14,241 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-3) ISPN000079: Channel web local address is node2, physical addresses are [172.17.0.3:55200]
    14:01:14,252 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-2) ISPN000094: Received new cluster view for channel keycloak: [node1|1] (2) [node1, node2]
    14:01:14,252 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-6) ISPN000094: Received new cluster view for channel server: [node1|1] (2) [node1, node2]
    14:01:14,253 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-6) ISPN000079: Channel server local address is node2, physical addresses are [172.17.0.3:55200]
    14:01:14,252 INFO  [org.infinispan.remoting.transport.jgroups.JGroupsTransport] (MSC service thread 1-2) ISPN000079: Channel keycloak local address is node2, physical addresses are [172.17.0.3:55200]
    
## Utiliser OmPing pour vérifier que le multicast est disponible

Sur 172.17.0.3:
    
    $ omping -m 230.0.0.4 -p 45688 172.17.0.3 172.17.0.4
    
Sur 172.17.0.4:
    
    $ omping -m 230.0.0.4 -p 45688 172.17.0.4 172.17.0.3
    
      
        