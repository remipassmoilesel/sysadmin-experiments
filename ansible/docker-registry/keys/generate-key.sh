#!/usr/bin/env bash

DOMAIN="docker.domain.com"

openssl req -nodes -newkey rsa:4096 -keyout registry.key -out registry.csr \
  -subj "/C=FR/ST=Grenoble/L=Grenoble/O=BeeBuzziness/OU=Docker registry/CN=$DOMAIN"

echo "You have to send the registry.csr file to the sysadmin to get a signed certificate"