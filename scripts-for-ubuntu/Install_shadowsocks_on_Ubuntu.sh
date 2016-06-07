#!/bin/bash

# Shadowsocks
sudo apt-get -y install python-pip
pip install shadowsocks
sudo echo '
{
    "server":"xx.xx.xx.xx",
    "server_port":443,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"xxxxxx",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": true,
    "workers": 1
}' > ~/shadowsocks.json
sudo mv ~/shadowsocks.json /etc/shadowsocks.json
cd /etc/apt/sources.list.d && sudo rm -f *
cd
sudo apt-get -y update


ssserver -c /etc/shadowsocks.json

#sudo ssserver -p 443 -k '!qaz@wsx!@#$' -m rc4-md5 --user nobody -d start
sudo ssserver -c /etc/shadowsocks.json --user nobody -d start