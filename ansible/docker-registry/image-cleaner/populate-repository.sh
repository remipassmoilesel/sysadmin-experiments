#!/usr/bin/env bash

# Delete images after: docker rm $(docker ps -a | grep "alpine" | awk '{ print $1 }')

docker rm $(docker ps -a | grep "alpine-temp-ctr" | awk '{ print $1 }')
docker rmi $(docker images | grep "alpine-registry-test" | awk '{ print $3 }')

docker pull alpine:latest

day=1

for i in $(seq 100); do

  # create timestamp with different days, some will be in future
  day=$((day+1))
  [[ $day -ge 28 ]] && day=1

  dayStr=$day
  [[ $day -lt 10 ]] && dayStr="0$dayStr"

  timestamp=$(date "+%Y%m$dayStr%H%M%S")

  # create a tag with a commit hash
  tag="$timestamp-186ef38"

  echo
  echo ==========================================
  echo Step $i: Pushing image tag=$tag timestamp=$timestamp day=$dayStr
  echo ==========================================

  docker run --name "alpine-temp-ctr_$i" alpine /bin/sh -c 'echo Hello > /hello.txt'
  docker commit "alpine-temp-ctr_$i" "docker.domain.com:5000/alpine-registry-test:$tag"

  docker push "docker.domain.com:5000/alpine-registry-test:$tag"

done
