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
/storage/.kodi/addons/service.system.docker/bin/docker rm $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
/storage/.kodi/addons/service.system.docker/bin/docker rmi $(/storage/.kodi/addons/service.system.docker/bin/docker images -aq)
/storage/.kodi/addons/service.system.docker/bin/docker system prune -af

cd /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master

echo rebuilding Docker...
/storage/.kodi/addons/service.system.docker/bin/docker build -t logitechmediaserver-rpi2 .

echo restarting services ...
systemctl enable lms.service
systemctl enable lmslog.service
systemctl enable lmslog.timer
systemctl start lms
systemctl start lmslog.timer


echo "Delete tmpfiles..overwrite .init.sh..."
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master /storage/.kodi/docker/
cd /storage/.kodi/docker
rm -f /storage/.kodi/docker/master.zip
rm -f -r /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master
rm -f /storage/.kodi/docker/getlms.sh

echo "Rebooting..."
reboot
echo "######################################################################################################################################################" >> /storage/Tomato/logs/getlms.log

