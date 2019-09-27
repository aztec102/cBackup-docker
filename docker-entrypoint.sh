#!/bin/bash

if [ "$(ls /opt/cbackup)" ];
then
    echo "cbackup установлен"
else
    echo "Подготавливаем cbackup"
    rsync -axHAX /opt/cbackup.orig/ /opt/cbackup/
fi

if [ "$(ls /var/lib/mysql)" ];
then
    echo "Подготовка DB не нужна"
else
    echo "Изменение пароля пользователя cbackup"
    echo "cbackup:cbackup_password" | chpasswd
    echo "Выполняем подготовку DB"
    service mysql stop
    chown -R mysql /var/lib/mysql
    /usr/bin/mysql_install_db
    service mysql start
    until mysqladmin ping; do sleep 1; done
    mysql -uroot -e "CREATE DATABASE IF NOT EXISTS cbackup CHARSET utf8 COLLATE utf8_general_ci;"
    mysql -uroot -e "CREATE USER IF NOT EXISTS 'cbackup'@'localhost' IDENTIFIED BY 'cbackup_password';"
    mysql -uroot -e "GRANT USAGE ON *.* TO cbackup@localhost;"
    mysql -uroot -e "GRANT ALL ON cbackup.* TO 'cbackup'@'127.0.0.1' IDENTIFIED BY 'cbackup_password';"
    mysql -uroot -e "GRANT ALL ON cbackup.* TO 'cbackup'@'localhost' IDENTIFIED BY 'cbackup_password';"
    mysql -uroot -e "GRANT ALL ON cbackup.* TO 'cbackup'@'%' IDENTIFIED BY 'cbackup_password';"
    mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');"
    echo "end"
fi

exec "$@"
