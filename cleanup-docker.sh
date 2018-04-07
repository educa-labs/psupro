#!/bin/bash

# remove exited containers:
sudo docker ps --filter status=dead --filter status=exited -aq | xargs -r sudo docker rm -v
    
# remove unused images:
sudo docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r sudo docker rmi

# remove unused volumes:
sudo  docker volume ls -qf dangling=true | xargs -r sudo docker volume rm

#clean up compose:
sudo docker-compose down -v --rmi all

