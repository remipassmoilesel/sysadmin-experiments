#!/usr/bin/env bash

docker stop -t 0 postgres keycloak keycloak2
docker rm postgres keycloak keycloak2


docker run --name postgres \
    -e POSTGRES_DATABASE=keycloak \
    -e POSTGRES_USER=keycloak \
    -e POSTGRES_PASSWORD=password \
    -e POSTGRES_ROOT_PASSWORD=password \
    -d postgres

docker run --name keycloak \
    --link postgres:postgres \
    -e POSTGRES_DATABASE=keycloak \
    -e POSTGRES_USER=keycloak \
    -e POSTGRES_PASSWORD=password \
    -d keycloak-ha-postgres-whelpers \
    -Djboss.node.name=node1 \
    -Djboss.bind.address=172.17.0.3 \
    -Djboss.bind.address.private=172.17.0.3 \
    -Djboss.default.multicast.address=230.0.0.4 \
    --server-config=standalone-ha.xml

docker run --name keycloak2 \
    --link postgres:postgres \
    -e POSTGRES_DATABASE=keycloak \
    -e POSTGRES_USER=keycloak \
    -e POSTGRES_PASSWORD=password \
    -d keycloak-ha-postgres-whelpers \
    -Djboss.node.name=node2 \
    -Djboss.bind.address=172.17.0.4 \
    -Djboss.bind.address.private=172.17.0.4 \
    -Djboss.default.multicast.address=230.0.0.4 \
    --server-config=standalone-ha.xml


