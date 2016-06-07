#!/bin/bash

# Update
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
echo "系统更新完成！"

# Shadowsocks
sudo apt-get -y install python-pip
pip install shadowsocks
sudo echo '
{
    "server":"xx.xx.xx.xx",
    "server_port":xxxx,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"xxxxxxxx",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": true,
    "workers": 1
}' > ~/shadowsocks.json
sudo mv ~/shadowsocks.json /etc/shadowsocks.json
cd /etc/apt/sources.list.d && sudo rm -f *
cd
sudo apt-get -y update
echo "修改/etc/shadowsocks.json成你自己的服务器信息"
echo "run command:'sslocal -c /etc/shadowsocks.json'"
echo "#!/bin/bash
sslocal -c /etc/shadowsocks.json" > ~/runss
echo "Shadowsocks安装完成！"

# Google-Chrome stable
#sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
#sudo apt-get -y update
#sudo apt-get -y install google-chrome-stable
#cd /etc/apt/sources.list.d && sudo rm -f *
#cd
#sudo apt-get -y Update
#echo "Google-Chrome安装完成！"

# Google-Chrome sina from http://down.tech.sina.com.cn/page/43719.html
wget "http://down.tech.sina.com.cn/download/d_load.php?d_id=43719&down_id=2&ip=220.172.112.149" -O google-chrome-unstable_current_amd64.deb
sudo dpkg -i google-chrome-unstable_current_amd64.deb
sudo rm -f google-chrome-unstable_current_amd64.deb
cd /etc/apt/sources.list.d && sudo rm -f *
cd
sudo apt-get -y update
echo "Google-Chrome安装完成！"

#卸载无关软件

#清理无用的包
sudo apt-get -y clean
sudo apt-get -y autoclean
sudo apt-get -y autoremove
echo “无关软件卸载完成！”
