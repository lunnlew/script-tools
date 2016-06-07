#!/bin/bash

function makersa {
	echo "生成新密钥:"
	echo "请输入email:"
	read Umail
	ssh-keygen -C $Umail -t RSA
}
function appendKey {
	echo "请输入远程用户名:"
	read Remote_User
	echo "请输入远程IP:"
	read Remote_IP
	echo "复制公钥文件中..."
	ssh $Remote_User@$Remote_IP "echo `cat ~/.ssh/id_rsa.pub` >> /$Remote_User/.ssh/authorized_keys"
	echo "更改authorized_keys权限为600中.."
	ssh $Remote_User@$Remote_IP "chmod 600 /$Remote_User/.ssh/authorized_keys"
}


if [ -f ~/.ssh/id_rsa.pub ] && [ -f ~/.ssh/id_rsa ]; then
	echo "是否使用已存在的密钥对(yes/no)"
	read YES_OR_NO
	if [ "$YES_OR_NO" = "yes" ]; then
		appendKey
	elif [ "$YES_OR_NO" = "no" ]; then
		makersa
	else
		echo "Sorry,Enter yes or no."
	  	exit 1
	fi
	
	echo "成功建立公钥信任!!"
	exit 0
else
	makersa
	appendKey
fi