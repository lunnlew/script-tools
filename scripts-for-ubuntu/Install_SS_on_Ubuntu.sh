apt-get install python-pip
pip install shadowsocks

ssserver -p 443 -k password -m rc4-md5
#see如果要后台运行：

sudo ssserver -p 443 -k password -m rc4-md5 --user nobody -d start
#see如果要停止：

sudo ssserver -d stop
#see如果要检查日志：

sudo less /var/log/shadowsocks.log

#see https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E#%E4%BD%BF%E7%94%A8