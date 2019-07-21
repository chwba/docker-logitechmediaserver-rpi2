#!/bin/sh
set -x
echo "######################################################################################################################################################" >> /storage/Tomato/logs/getlms.log
echo stopping lms.service
systemctl stop lmslog.timer
systemctl stop lms
sleep 3
systemctl disable lms
systemctl disable lmslog.service
systemctl disable lmslog.timer
/storage/.kodi/addons/service.system.docker/bin/docker stop $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
sleep 1
/storage/.kodi/addons/service.system.docker/bin/docker rm $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
sleep 1
/storage/.kodi/addons/service.system.docker/bin/docker rmi $(/storage/.kodi/addons/service.system.docker/bin/docker images -aq)
sleep 1
/storage/.kodi/addons/service.system.docker/bin/docker system prune -af
sleep 1
/storage/.kodi/addons/service.system.docker/bin/docker image prune -af
sleep 1
/storage/.kodi/addons/service.system.docker/bin/docker container prune -f
sleep 1

cd /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master
sleep 1

echo rebuilding Docker...
/storage/.kodi/addons/service.system.docker/bin/docker build -t logitechmediaserver-rpi2 . --security-opt apparmor=docker-default

echo restarting services ...
sleep 5
systemctl enable lms.service
systemctl enable lmslog.service
systemctl enable lmslog.timer
systemctl start lms
systemctl start lmslog.timer


echo "Delete tmpfiles..overwrite .init.sh..."
cd /storage/.kodi/docker
rm -f /storage/.kodi/docker/init.sh
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/init.sh /storage/.kodi/docker
chmod +x /storage/.kodi/docker/init.sh
rm -f /storage/.kodi/docker/master.zip
rm -f -r /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master
rm -f /storage/.kodi/docker/getlms.sh
sleep 15

echo reconnect vpn..
kodi-send --action="RunScript(/storage/.kodi/addons/service.vpn.manager/api.py, Connect 1)"
#echo "Rebooting..."
set +x
#reboot
echo "######################################################################################################################################################" >> /storage/Tomato/logs/getlms.log
