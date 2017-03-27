#!/bin/bash

TARGET_DIR="/opt/netspectrum/aws/ubuntu-desktop/"

#/usr/bin/x11vnc -xkb -auth /var/run/lightdm/root/:0 -noxrecord -noxfixes -noxdamage -rfbauth $TARGET_DIR/vnc/passwd -forever -bg -rfbport 5901 -o /var/log/x11vnc.log &
#/usr/bin/x11vnc  -xkb -repeat -xfixes -noxrecord -xdamage -loop -auth /var/run/lightdm/root/:0 -rfbauth $TARGET_DIR/vnc/passwd -rfbport 5901 -o /var/log/x11vnc.log &> /tmp/x11vnc-stdout.log&
/usr/bin/x11vnc -repeat -xkb -shared -xfixes -noxrecord -xdamage -loop -auth /var/run/lightdm/root/:0 -rfbauth $TARGET_DIR/passwd -rfbport 5901 -o /var/log/x11vnc.log &> /tmp/x11vnc-stdout.log &

# start websockify with some delay
sleep 5

#$TARGET_DIR/noVNC/utils/launch.sh --listen 80 --vnc localhost:5901 &
#/usr/bin/python $TARGET_DIR/noVNC/utils/websockify/run -v --daemon --record=/root/websockify-record --web $TARGET_DIR/noVNC/ 80 localhost:5901 > /var/log/websockify.log 2>&1 &
#$TARGET_DIR/noVNC/utils/websockify/run -v  --record=/root/websockify-record --web $TARGET_DIR/noVNC/ 80 localhost:5901  &>  /var/log/websockify.log &
$TARGET_DIR/noVNC/utils/websockify/run -v --cert=$TARGET_DIR/self.pem --web $TARGET_DIR/noVNC/ 443 localhost:5901  &>  /var/log/websockify.log &

# set up vnc password from instance id on first time bootup
if [ -f $TARGET_DIR/passwd ]; then
	exit 0;
fi

id=`curl http://169.254.169.254/latest/meta-data/instance-id`;
echo $id | /usr/bin/vncpasswd -f > $TARGET_DIR/passwd;
chmod og-rwx $TARGET_DIR/passwd;

