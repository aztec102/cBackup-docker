CREATE DATABASE IF NOT EXISTS cbackup CHARSET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS 'cbackup'@'localhost' IDENTIFIED BY 'cbackup_password';
GRANT USAGE ON *.* TO cbackup@localhost;
GRANT ALL ON cbackup.* TO 'cbackup'@'127.0.0.1' IDENTIFIED BY 'cbackup_password';
GRANT ALL ON cbackup.* TO 'cbackup'@'localhost' IDENTIFIED BY 'cbackup_password';
GRANT ALL ON cbackup.* TO 'cbackup'@'%' IDENTIFIED BY 'cbackup_password';
