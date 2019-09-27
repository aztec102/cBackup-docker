#!/bin/bash
docker run \
        --name mysql-cbackup \
        --detach \
        --net cbackup-net \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /home/docker/mysql-cbackup/mysql_data:/var/lib/mysql \
        --env MYSQL_ROOT_PASSWORD="root_password" \
        --publish 3306:3306 \
        chatlamin/mysql-cbackup:latest

docker logs --follow mysql-cbackup

