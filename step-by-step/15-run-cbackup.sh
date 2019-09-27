#!/bin/bash
docker run \
        --name cbackup \
        --detach \
        --net cbackup-net \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /home/docker/cbackup/cbackup:/opt/cbackup \
        --volume /home/docker/cbackup/logs/apache2:/var/log/apache2 \
        --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
        --publish 80:80 \
        --cap-drop SYS_ADMIN \
        chatlamin/cbackup:latest

docker logs --follow cbackup