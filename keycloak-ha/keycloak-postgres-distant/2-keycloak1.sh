#!/usr/bin/env bash

docker run --name keycloak \
      -e KEYCLOAK_USER=keycloak \
      -e KEYCLOAK_PASSWORD=keycloak \
      -e POSTGRES_DATABASE=keycloak \
      -e POSTGRES_USER=keycloak \
      -e POSTGRES_PASSWORD=password \
      -e POSTGRES_PORT_5432_TCP_ADDR=10.0.4.230 \
      -e POSTGRES_PORT_5432_TCP_PORT=5432 \
      -p 8080:8080 \
      -d jboss/keycloak-ha-postgres

