#!/usr/bin/env bash

# Build current directory and launch image

./build-image.sh

docker run -p 80:80 -p 8888:8888 -p 9999:9999 health-check-test