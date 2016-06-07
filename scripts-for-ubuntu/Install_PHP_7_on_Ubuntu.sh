#!/bin/bash

#Install PHP 7 
sudo apt-get -y install python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get -y install php7.0 &&

#Install Apache 2.4 
sudo add-apt-repository ppa:ondrej/apache2
sudo apt-get update
sudo apt-get -y install apache2 &&

#Install MySQL 5.6 
sudo add-apt-repository -y ppa:ondrej/mysql-5.6
sudo apt-get update
sudo apt-get -y install mysql-server-5.6 &&

#Install Other Requirements 
sudo apt-cache search php7-*
#sudo apt-cache search php7-* | sudo apt-get -y install
sudo apt-get -y install libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json 

#Install Phpmyadmin
#sudo add-apt-repository -y ppa:nijel/phpmyadmin
#sudo apt-get update
#sudo apt-get -y install phpmyadmin &&

##Not Support Installing for php7
##You added it manually
cd ~
wget https://files.phpmyadmin.net/phpMyAdmin/4.5.3.1/phpMyAdmin-4.5.3.1-english.tar.gz 
tar -zxvf phpMyAdmin-4.5.3.1-english.tar.gz
sudo ln -s ~/phpMyAdmin-4.5.3.1-english /var/www/html/phpMyAdmin


#Verify Setup
echo "<?php
phpinfo();
?>" > ~/info.php
sudo mv ~/info.php /var/www/html/index.php

#restart apache2 mysql
sudo systemctl restart apache2 mysql #15.04

#Open Url
xdg-open http://localhost/index.php

