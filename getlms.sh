#!/usr/bin/bash
set -x 
echo stopping lms.service
systemctl stop lms 
sleep 5

/storage/.kodi/addons/service.system.docker/bin/docker stop $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
/storage/.kodi/addons/service.system.docker/bin/docker rm $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq)
/storage/.kodi/addons/service.system.docker/bin/docker rmi $(/storage/.kodi/addons/service.system.docker/bin/docker images -aq)

sleep 30

cd /storage/.kodi/docker                                                                  && \
wget https://github.com/g-uru/docker-logitechmediaserver-rpi2/archive/master.zip          && \
unzip master.zip                                                                          && \
cd docker-logitechmediaserver-rpi2-master                                                 && \
docker build -t logitechmediaserver-rpi2 .                                                && \
cd /storage/.kodi/docker                                                                  && \
rm -f master.zip                                                                          && \
rm -f -r docker-logitechmediaserver-rpi2-master                                           && \
rm -f .gitignore                                                                          ;  
ls -la

sleep 5 
echo restarting lms.service
systemctl start lms
echo done ...

read -t 10 -n 1 -p "Show journalctl -u lms? [Y/n] " reply;
if [ "$reply" != "" ]; then journalctl -u lms; fi
if [ "$reply" != "n" ]; then echo
    fi
	
read -t 10 -n 1 -p "Show more/again? [Y/n] " reply;
if [ "$reply" != "" ]; then journalctl -u lms; fi
if [ "$reply" != "n" ]; then echo
    fi
	