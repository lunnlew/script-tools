sudo apt-get install --no-install-recommends ubuntu-desktop
sudo apt-get install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
sudo apt-get install vnc4server
sudo cp /usr/bin/vncserver /usr/bin/vncserver.bkp

#see http://www.krizna.com/ubuntu/install-vnc-server-ubuntu-14-04/

#sudo vi /usr/bin/vncserver

#"# exec /etc/X11/xinit/xinitrcnn".

# "# exec /etc/X11/xinit/xinitrcnn".
#       "gnome-panel &n".
#       "gnome-settings-daemon &n".
#       "metacity &n".
#       "nautilus &n".
#       "gnome-terminal &n".

vncserver



#for service
echo '### BEGIN INIT INFO
# Provides:          VNCSERVER
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO
unset VNCSERVERARGS
VNCSERVERS=""
[ -f /etc/vncservers.conf ] && . /etc/vncservers.conf
prog=$"VNC server"
start() {
 . /lib/lsb/init-functions
 REQ_USER=$2
 echo -n $"Starting $prog: "
 ulimit -S -c 0 >/dev/null 2>&1
 RETVAL=0
 for display in ${VNCSERVERS}
 do
 export USER="${display##*:}"
 if test -z "${REQ_USER}" -o "${REQ_USER}" == ${USER} ; then
 echo -n "${display} "
 unset BASH_ENV ENV
 DISP="${display%%:*}"
 export VNCUSERARGS="${VNCSERVERARGS[${DISP}]}"
 su ${USER} -c "cd ~${USER} && [ -f .vnc/passwd ] && vncserver :${DISP} ${VNCUSERARGS}"
 fi
 done
}
stop() {
 . /lib/lsb/init-functions
 REQ_USER=$2
 echo -n $"Shutting down VNCServer: "
 for display in ${VNCSERVERS}
 do
 export USER="${display##*:}"
 if test -z "${REQ_USER}" -o "${REQ_USER}" == ${USER} ; then
 echo -n "${display} "
 unset BASH_ENV ENV
 export USER="${display##*:}"
 su ${USER} -c "vncserver -kill :${display%%:*}" >/dev/null 2>&1
 fi
 done
 echo -e "n"
 echo "VNCServer Stopped"
}
case "$1" in
start)
start $@
;;
stop)
stop $@
;;
restart|reload)
stop $@
sleep 3
start $@
;;
condrestart)
if [ -f /var/lock/subsys/vncserver ]; then
stop $@
sleep 3
start $@
fi
;;
status)
status Xvnc
;;
*)
echo $"Usage: $0 {start|stop|restart|condrestart|status}"
exit 1
esac' > ~/vncserver

sudo mv ~/vncserver /etc/init.d/vncserver
sudo chmod +x  /etc/init.d/vncserver

sudo echo 'VNCSERVERS="1:krizna"
VNCSERVERARGS[1]="-geometry 1024x768"' >>  /etc/vncservers.conf

su - bobby

vncpasswd