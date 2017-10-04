#!/usr/bin/env bash
docker run --name keycloak2 --link postgres:postgres \
      -e POSTGRES_DATABASE=keycloak \
      -e POSTGRES_USER=keycloak \
      -e POSTGRES_PASSWORD=password \
      -p 8081:8080 \
      -d jboss/keycloak-ha-postgres