#!/bin/bash

#部署路径
WEB_PATH='/var/www/norma'
WEB_USER='www'
WEB_USERGROUP='www'
 
echo "开始部署web应用"
cd $WEB_PATH
echo "拉取仓库代码中"
git reset --hard origin/master
git clean -f
git pull
git checkout master

echo "更新文件权限中"
chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
echo "结束部署."