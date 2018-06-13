#!/bin/bash

# mercredi 30 mai 2018, 17:51:16 (UTC+0200)

set -x
set -e

docker build docker-image -t volumes-examples:0.1
docker run -p 8082:80 volumes-examples:0.1