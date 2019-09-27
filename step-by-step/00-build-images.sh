#!/bin/bash
cd ../
docker build -t chatlamin/mysql-cbackup . -f mysql-cbackup/Dockerfile
docker build -t chatlamin/cbackup . -f cbackup/Dockerfile