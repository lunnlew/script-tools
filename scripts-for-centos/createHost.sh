#!/bin/bash

function loadCert {

}
function createCert {
    echo "是否使用自签名的服务器证书(yes/no)"
    read YES_OR_NO
    if [ "$YES_OR_NO" = "yes" ]; then
        openssl genrsa -out $MAIN_DOMAIN.key 2048
        openssl req -new -key $MAIN_DOMAIN.key -out $MAIN_DOMAIN.csr
        openssl x509 -req -days 365 -in $MAIN_DOMAIN.csr -signkey $MAIN_DOMAIN.key -out $MAIN_DOMAIN.crt
        cp $MAIN_DOMAIN.crt /etc/pki/tls/certs/
        cp $MAIN_DOMAIN.key /etc/pki/tls/private/
        cp $MAIN_DOMAIN.csr /etc/pki/tls/private/
    elif [ "$YES_OR_NO" = "no" ]; then
        loadCert
    else
        echo "Sorry,Enter yes or no."
    fi
}
function createHost {
        echo "请输入域名"
        read MAIN_DOMAIN
        echo "请输入主机目录"
        read WEB_ROOT
        echo "<VirtualHost *:80>
        DocumentRoot $WEB_ROOT
        ServerName $MAIN_DOMAIN
        ErrorLog logs/$MAIN_DOMAIN-error_log
        CustomLog logs/$MAIN_DOMAIN-access_log common" > $MAIN_DOMAIN.conf;
        echo "<Directory $WEB_ROOT>
            Options FollowSymLinks
            AllowOverride All
        </Directory>" >> $MAIN_DOMAIN.conf;

        echo "</VirtualHost>" >> $MAIN_DOMAIN.conf;



        echo "是否启用HTTPS(yes/no)"
        read YES_OR_NO
        if [ "$YES_OR_NO" = "yes" ]; then
            echo "<VirtualHost *:443>
            DocumentRoot $WEB_ROOT
            ServerName $MAIN_DOMAIN
            ErrorLog logs/$MAIN_DOMAIN-ssh-error_log
            CustomLog logs/$MAIN_DOMAIN-ssh-access_log common" >> $MAIN_DOMAIN.conf;

            if [ -f /etc/pki/tls/certs/$MAIN_DOMAIN.crt ] && [ -f /etc/pki/tls/private/$MAIN_DOMAIN.key ]; then
                echo "是否使用已存在的服务器证书(yes/no)"
                read YES_OR_NO
                if [ "$YES_OR_NO" = "yes" ]; then
                        echo '启用中';
                elif [ "$YES_OR_NO" = "no" ]; then
                    createCert
                else
                    echo "Sorry,Enter yes or no."
                fi
            else
                createCert
            fi

            echo "SSLEngine on
            SSLProtocol all -SSLv2
            SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW
            SSLCertificateFile /etc/pki/tls/certs/$MAIN_DOMAIN.crt
            SSLCertificateKeyFile /etc/pki/tls/private/$MAIN_DOMAIN.key" >> $MAIN_DOMAIN.conf;


            echo "<Directory $WEB_ROOT>
                Options FollowSymLinks
                AllowOverride All
            </Directory>" >> $MAIN_DOMAIN.conf;
            echo "</VirtualHost>" >> $MAIN_DOMAIN.conf;
        fi
}
createHost
if [ -f $MAIN_DOMAIN.conf ]; then
    echo "成功建立VirtualHost配置文件$MAIN_DOMAIN.conf";
    exit 0
else
    echo "VirtualHost配置文件建立失败!!!";
    exit 1
fi

#vi /etc/sysconfig/iptables
#-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
#/etc/init.d/iptables restart