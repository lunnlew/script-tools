#!/bin/bash

print() {
    echo
    echo "## $1"
    echo
}

bail() {
    echo 'Error executing command, exiting'
    exit 1
}

exec_cmd_nobail() {
    echo "+ $1"
    bash -c "$1"
}

exec_cmd() {
    exec_cmd_nobail "$1" || bail
}

print "Checking pre_install packages..."


##检查依赖工具包
PRE_INSTALL_PKGS=""

if [ ! -x /usr/bin/pip ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} python-pip"
fi

if [ ! -x /usr/bin/curl ] && [ ! -x /usr/bin/wget ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} curl"
fi

#更新apt-get缓存
print "Populating apt-get cache..."
exec_cmd 'sudo apt-get update'

if [ "X${PRE_INSTALL_PKGS}" != "X" ]; then
    print "Installing packages required for setup:${PRE_INSTALL_PKGS}..."
    # This next command needs to be redirected to /dev/null or the script will bork
    # in some environments
    exec_cmd "sudo apt-get install -y${PRE_INSTALL_PKGS} > /dev/null 2>&1"


    #更新apt-get缓存
   print 'Running `apt-get update` for you...'
   exec_cmd 'sudo apt-get update'
fi

 
if [ ! -d /usr/local/lib/python2.7/dist-packages/shadowsocks ]; then
   print 'Installing shadowsocks...'
    exec_cmd 'pip install shadowsocks'
fi

print '请输入服务器的IP:'
read IP

print '请输入提供服务的端口:'
read PORT

print '请输入提供服务的密码:'
read PASS

if [ "${PORT}" == "" ]; then
    PORT='443'
fi
if [ "X$PASS" == "X" ]; then
    PASS='idontlikeyou!!!'
fi

exec_cmd "echo '
{
    \"server\":\"$IP\",
    \"server_port\":$PORT,
    \"local_address\": \"127.0.0.1\",
    \"local_port\":1080,
    \"password\":\"$PASS\",
    \"timeout\":300,
    \"method\":\"aes-256-cfb\",
    \"fast_open\": true,
    \"workers\": 1
}' > ~/shadowsocks.json"

exec_cmd 'mv ~/shadowsocks.json /etc/shadowsocks.json'
exec_cmd 'cd /etc/apt/sources.list.d && sudo rm -f * && cd ~'
exec_cmd 'ssserver -c /etc/shadowsocks.json --user nobody -d start'