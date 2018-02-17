#!/usr/bin/env bash

echo "Need htpasswd utility: sudo apt update apache2-utils"

USER="username"
PASSWORD="xxxxxxx"

# remove previous file
mv htpasswd htpasswd.bak
mv htpasswd.base64.yml htpasswd.base64.yml.bak

# create a new htpasswd file, we MUST force use of bcrypt (-b)
htpasswd -cbB htpasswd $USER $PASSWORD

# create a token for web registry
BASE_64=$(echo -n "$USER:$PASSWORD" | base64)
echo "docker_registry_web_auth: $BASE_64" > htpasswd.base64.yml