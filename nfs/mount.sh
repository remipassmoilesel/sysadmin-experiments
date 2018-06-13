#!/usr/bin/env bash

# You will need nfs-common package !

set -x

mkdir -p example-mount-point

sudo mount -t nfs -o rw 10.0.1.139:/srv/shared/ $(pwd)/example-mount-point