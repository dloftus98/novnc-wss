cd /opt/netspectrum/aws/ubuntu-desktop

sudo sh -c 'curl -Ls https://github.com/dloftus98/novnc-wss/raw/master/self.pem >self.pem'
sudo chown ubuntu:ubuntu self.pem

cd bin
mv rc-local.sh rc-local.sh.orig
curl -Ls https://github.com/dloftus98/novnc-wss/raw/master/rc-local.sh >rc-local.sh

echo Rebooting in 5 seconds
sleep 5s
sudo reboot

