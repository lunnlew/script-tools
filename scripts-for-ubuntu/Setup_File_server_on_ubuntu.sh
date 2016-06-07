#!/bin/bash

sudo apt-get update
sudo apt-get install -y samba samba-common python-glade2

sudo mkdir -p /shares/storage
sudo addgroup storage
sudo chown root:storage /shares/storage/
sudo chmod 777 -R /shares/storage/

sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup

echo "[storage]
comment = storage Share
path = /shares/storage
valid users = @storage
guest ok = no
writable = yes
browsable = yes" >> /etc/samba/smb.conf

sudo service smbd restart

#for new user
sudo useradd lunnlew -s /usr/sbin/nologin -G storage
sudo smbpasswd -a lunnlew

#for existing user
#sudo usermod lunnlew -G storage

#sudo usermod dave -G smbproj1,smbproj2