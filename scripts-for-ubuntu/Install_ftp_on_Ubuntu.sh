#!/bin/bash

#Install vsftpd
apt-get update
apt-get install vsftpd

echo "listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
allow_writeable_chroot=YES
ftpd_banner=Welcome to blah FTP service.
pasv_enable=Yes
pasv_min_port=40000
pasv_max_port=49999" > ~/vsftpd.conf

mv ~/vsftpd.conf  /etc/vsftpd.conf

echo '请输入FTP用户名:'
read Ftp_User

echo '请输入FTP用户密码:'
read Ftp_Pass

useradd -m $Ftp_User -s /usr/sbin/nologin
echo $Ftp_User:$Ftp_Pass | /usr/sbin/chpasswd

echo "/usr/sbin/nologin" >> /etc/shells
#usermod -s /bin/bash lunnlew

service vsftpd restart

echo '启用ftp成功!'