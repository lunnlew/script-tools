#!/bin/bash


sudo apt-get install -y openssh-server openssh-client
sudo /etc/init.d/ssh restart
sudo apt-get install -y git
ssh-keygen -C "lunnlew@qq.com" -t rsa

cat ~/.ssh/id_rsa.pub