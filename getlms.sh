#!/bin/sh
set -x
echo stopping lms.service
systemctl stop lms
systemctl stop lmslog
sleep 2
/storage/.kodi/addons/service.system.docker/bin/docker stop $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
/storage/.kodi/addons/service.system.docker/bin/docker rm $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
/storage/.kodi/addons/service.system.docker/bin/docker rmi $(/storage/.kodi/addons/service.system.docker/bin/docker images -aq)
/storage/.kodi/addons/service.system.docker/bin/docker system prune -af

cd /storage/.kodi/docker
wget https://github.com/g-uru/docker-logitechmediaserver-rpi2/archive/master.zip
unzip master.zip
cd docker-logitechmediaserver-rpi2-master
echo rebuilding Docker...
/storage/.kodi/addons/service.system.docker/bin/docker build -t logitechmediaserver-rpi2 .										

echo restarting services ...
systemctl start lmslog
systemctl start lms

# for interactive mode
#read -t 10 -n 1 -p "Show journalctl -u lms? [Y/n] " reply;
#if [ "$reply" != "" ]; then journalctl -u lms; fi
#if [ "$reply" != "n" ]; then echo
#    fi	
#read -t 10 -n 1 -p "Show more/again? [Y/n] " reply;
#if [ "$reply" != "" ]; then journalctl -u lms; fi
#if [ "$reply" != "n" ]; then echo
#    fi
#journalctl -u lms;
#echo "Waiting 10 seconds for LMS to finish then journalctl -u lms again..."
#sleep 10
#journalctl -u lms;
#read -p "Press any key to reboot"
#reboot now

echo Delete tmpfiles..update getlms.sh...
cd /storage/.kodi/docker
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/getlms.sh /storage/.kodi/docker
chmod +x /storage/.kodi/docker/getlms.sh
rm -f master.zip
rm -f -r docker-logitechmediaserver-rpi2-master
ls -la

#echo Waiting 20 Seconds for LMS to finish ...
#sleep 20
#journalctl -u lms
#echo Rebooting in 5 seconds  ...
#sleep 5
reboot now