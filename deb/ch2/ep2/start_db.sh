#!/bin/bash
# start mariadb docker container
docker run --name mariadb \
    -p 127.0.0.1:3306:3306 \
    -e MYSQL_ROOT_PASSWORD=mysql \
    -v $(pwd)/data:/docker-entrypoint-initdb.d \
    --rm -d \
    mariadb:latest