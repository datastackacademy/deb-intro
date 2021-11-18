#!/bin/bash
# start mariadb docker container with empty database named spotify
docker run --name mariadb \
    -p 127.0.0.1:3306:3306 \
    -v sqlvolume:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=mysql \
    -e MYSQL_DATABASE=spotify \
    --rm -d \
    mariadb:latest