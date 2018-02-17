#!/usr/bin/env bash

docker inspect --format '{{ .NetworkSettings.IPAddress  }} {{ .Config.Image  }}' $(docker ps -q)

