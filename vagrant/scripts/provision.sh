#!/bin/bash

PASSWORD='root'

sudo apt-add-repository -y ppa:ondrej/php
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install mc

sudo apt-get -y install apache2

sudo apt-get -y install php5.6
sudo apt-get -y install php-pear
sudo apt-get -y install php5.6-mcrypt
sudo apt-get -y install php5.6-curl
sudo apt-get -y install php5.6-gd
sudo apt-get -y install php5.6-intl
sudo apt-get -y install php5.6-xml
sudo apt-get -y install php5.6-mbstring
sudo apt-get -y install php5.6-zip
sudo apt-get -y install php5.6-xdebug
sudo apt-get -y install php5.6-mysql

sudo pecl channel-update pecl.php.net

sudo cat /shared/vagrant/config/php.ini >> /etc/php5/apache2/php.ini
sudo cat /shared/vagrant/config/php.ini >> /etc/php5/cli/php.ini

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf


if [ -f /shared/vagrant/mysql/export.tgz ];
then
    sudo tar zxf /shared/vagrant/mysql/export.tgz
    sudo rm -rf /var/lib/mysql
    sudo mv var/lib/mysql /var/lib/mysql
else
    mysql -uroot -proot < /shared/vagrant/scripts/setup.sql
fi
sudo /etc/init.d/mysql restart

sudo cp /shared/vagrant/config/apache-000-default.conf /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
service apache2 restart

sudo apt-get -y install git
git config --global user.email "lokilevente@lokilevente.hu"
git config --global user.name "Levente Löki"

curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony

wget -q https://phar.phpunit.de/phpunit.phar
chmod a+x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
