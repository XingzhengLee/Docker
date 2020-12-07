#!/bin/bash

############################## image ##############################
# pull image to local
docker pull [image name][:tag]

# view all local images
docker images

# remove local image
docker rmi [image ID]

# input/output image (non-standard) and add repository/tag
docker save -o [image file] [image ID]
docker load -i [image file]
# add image name and its version
docker tag [image ID] [image name]:[version]

############################## container ##############################
# run container
docker run [image ID]|[image name][:tag]
# -d: background
# -p: map local & container port
# --name: container name
docker run -d -p [local port]:[container port] --name [container name] [image ID]|[image name][:tag]

# view running container
# -a: view all container (including containers not running)
# -q: view only container ID
docker ps [-aq]

# view container log
docker logs -f [container ID]

# enter container
docker exec -it [container ID] bash

# remove container (stop before remove container)
docker stop [container ID]
docker rm [container ID]
# remove all containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# start container
docker start [container ID]

# deploy file in container
docker cp [file name] [container ID]:[path in container]

# create data volume for mapping (/var/lib/docker/volumes/[volume name]/_data)
docker volume create [volume name]

############################## data volume ##############################
# view volume
docker volume inspect [volume name]
# view all volumes
docker volume ls

# remove data volume
docker volume rm [volume name]

# apply data volume (sync files in contianer to local)
docker run -v [volume name]:[path in container] [image ID]
# apply data volume using path (sync not)
docker run -v [path in local]:[path in container] [image ID]

############################## create docker image ##############################
# create docker image
docker build -t [image name]:[tag] .
# Dockerfile
from: dependency environment
copy: copy content to image
workdir: default working directory
cmd: executive command

############################## docker-compose ##############################
# Docker-Compose
# docker-compose.yml
# key:value
# indent with two spaces (do not use tab)
version: ''
services:
  [service name]:
    restart: always
    image: [image name]
    container_name: [container name]
    ports:
      - [local port]:[container port]
    environment:
      ...
      TZ: Asia/Shanghai
    volumes:
      - ...
      - [path in local]:[path in container]
  [service name]:
    restart: always
    image: [image name]
    container_name: [container name]
    ports:
      - [local port]:[container port]
    environment:
      ...
      TZ: Asia/Shanghai
    volumes:
      - [path in local]:[path in container]
...

# run docker-compose
docker-compose up -d

# stop and remove container
docker-compose down

# start/stop containers maintained by docker-compose
docker-compose start|stop|restart

# docker-compose view
docker-compose ps

# docker-compose logs
docker-compose logs -f

############################## docker-compose + Dockerfile ##############################
# docker-compose + Dockerfile
# docker-compose.yml
version: ''
services:
  [service name]:
    restart: always
    build:
       context: [path to Dockerfile name]
       dockerfile: Dockerfile
    image: [image name (custom)]
    container_name: [container name]
    ports:
      - [local port]:[container port]
    environment:
      ...
      TZ: Asia/Shanghai
    volumes:
      - ...
      - [path in local]:[path in container]
# Dockerfile
from: dependency environment
copy: copy content to image

# create docker image
docker-compose build
# run docker-compose + Dockerfile
docker-compose up -d
