cls
echo off
rem deploy path
set WEB_PATH="D:/localuser/bjjy"
set WEB_USER='everyone'
set WEB_USERGROUP='everyone'

echo start deploy
cd %WEB_PATH%

echo pull source
git reset --hard origin/master
git clean -f
git pull
git checkout master

echo update pss

echo Y|cacls %WEB_PATH% /c /p %WEB_USER%:c
rem echo y|icacls %WEB_PATH% /grant %WEB_USER%:RX

echo end deploy