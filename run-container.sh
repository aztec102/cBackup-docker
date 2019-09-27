docker run \
        --name cbackup \
        --detach \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /home/docker/cbackup/cbackup:/opt/cbackup \
        --volume /home/docker/cbackup/logs/apache2:/var/log/apache2 \
        --volume /home/docker/cbackup/mysql_data:/var/lib/mysql \
        --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
        --publish 80:80 \
        --publish 3306:3306 \
        --cap-drop SYS_ADMIN \
        chatlamin/cbackup:latest

docker logs --follow cbackup
