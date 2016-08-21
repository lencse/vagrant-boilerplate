CREATE DATABASE vagrantdb;

CREATE USER 'vagrantdb'@'%' IDENTIFIED BY 'vagrantdb';
GRANT ALL PRIVILEGES ON *.* TO 'vagrantdb'@'%' WITH GRANT OPTION;

CREATE USER vagrantdb@localhost IDENTIFIED BY 'vagrantdb';
GRANT ALL PRIVILEGES ON *.* TO vagrantdb@localhost WITH GRANT OPTION;
