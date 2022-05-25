#!/bin/sh

echo "Cleaning up Docker Components"

if ! command -v docker > /dev/null 2>&1; then
  echo "Docker not installed"
  exit 0
fi 

echo "Removing Volumes"
docker volume rm $(docker volume ls -qf dangling=true) > /dev/null 2>&1

echo "Removing Networks"
docker network rm $(docker network ls | grep "bridge" | awk '/ / { print $1 }') > /dev/null 2>&1

echo "Removing Images"
docker rmi $(docker images --filter "dangling=true" -q --no-trunc) > /dev/null 2>&1
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }') > /dev/null 2>&1

echo "Removing Containers"
docker rm $(docker ps -qa --no-trunc --filter "status=exited") > /dev/null 2>&1

echo "Cleaning Complete"
