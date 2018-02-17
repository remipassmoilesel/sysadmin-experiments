#!/usr/bin/env bash

docker pull alpine:latest

# docker tag alpine:latest domain.net:5001/alpine-modified:1.0

for i in $(seq 100); do

  echo "Step $i"

  docker run --name alpine-ctr-$i alpine /bin/echo Hello$i > hello.txt
  docker commit alpine-ctr-$i domain.net:5001/alpine-modified:1.$i

  docker push domain.net:5001/alpine-modified:1.$i

done

