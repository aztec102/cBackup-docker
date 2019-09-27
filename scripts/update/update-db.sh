#!/bin/bash
docker exec -i mysql-cbackup /usr/bin/mysql -u root --password=root_password cbackup < update-db.sql