#!/usr/bin/env bash

docker stop -t 0 keycloak keycloak2
docker rm keycloak keycloak2

docker run --name keycloak \
    -e KEYCLOAK_USER=keycloak \
    -e KEYCLOAK_PASSWORD=keycloak \
    -e POSTGRES_DATABASE=keycloak \
    -e POSTGRES_USER=keycloak \
    -e POSTGRES_PASSWORD=keycloak \
    -e POSTGRES_PORT_5432_TCP_ADDR=10.0.4.230 \
    -e POSTGRES_PORT_5432_TCP_PORT=5432 \
    -d keycloak-ha-postgres-whelpers \
    -Djboss.node.name=node1 \
    -Djboss.bind.address=172.17.0.2 \
    -Djboss.bind.address.private=172.17.0.2 \
    -Djboss.default.multicast.address=230.0.0.4 \
    --server-config=standalone-ha.xml

docker run --name keycloak2 \
    -e KEYCLOAK_USER=keycloak \
    -e KEYCLOAK_PASSWORD=keycloak \
    -e POSTGRES_DATABASE=keycloak \
    -e POSTGRES_USER=keycloak \
    -e POSTGRES_PASSWORD=keycloak \
    -e POSTGRES_PORT_5432_TCP_ADDR=10.0.4.230 \
    -e POSTGRES_PORT_5432_TCP_PORT=5432 \
    -d keycloak-ha-postgres-whelpers \
    -Djboss.node.name=node2 \
    -Djboss.bind.address=172.17.0.3 \
    -Djboss.bind.address.private=172.17.0.3 \
    -Djboss.default.multicast.address=230.0.0.4 \
    --server-config=standalone-ha.xml


