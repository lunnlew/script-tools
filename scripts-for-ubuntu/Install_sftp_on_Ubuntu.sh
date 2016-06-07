#!/bin/bash

#Install SFTP
sudo apt-get install openssh-server
sudo groupadd ftpuser

echo "Subsystem sftp internal-sftp
Match group ftpuser
ChrootDirectory %h
X11Forwarding no
AllowTcpForwarding no
ForceCommand internal-sftp" >> /etc/ssh/sshd_config

sudo service ssh restart

sudo useradd -m lunnlew -g ftpuser -s /usr/sbin/nologin
sudo chown root /home/lunnlew
sudo mkdir /home/lunnlew/www
sudo chown lunnlew:ftpuser /home/lunnlew/www

sudo usermod lunnlew -g ftpuser -s /usr/sbin/nologin