#!/bin/bash

# mercredi 13 juin 2018, 13:47:30 (UTC+0200)

# You will need glusterfs-client package !

set -x

mkdir example-mount-point

sudo mount -t glusterfs 10.0.1.30:/volume1 $(pwd)/example-mount-point
