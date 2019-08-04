#!/bin/sh
set -x
echo Disconnecting VPN...
kodi-send --action="RunScript(/storage/.kodi/addons/service.vpn.manager/api.py, Disconnect)"
sleep 5
echo
#echo get master from repo..
#cd /storage/.kodi/docker
#wget https://github.com/chwba/docker-logitechmediaserver-rpi2/archive/master.zip && unzip master.zip
cd /storage/git/docker-logitechmediaserver-rpi2
git pull

# overwrite service files
#echo copy service files frop repo...
#cp -f /storage/git/docker-logitechmediaserver-rpi2/*.service /storage/.kodi/addons/service.system.docker/examples
#cp -f /storage/git/docker-logitechmediaserver-rpi2/*.service /storage/.config/system.d/
#cp -f /storage/git/docker-logitechmediaserver-rpi2/*.timer /storage/.kodi/addons/service.system.docker/examples
#cp -f /storage/git/docker-logitechmediaserver-rpi2/*.timer /storage/.config/system.d/
#systemctl daemon-reload

#echo copy sh files from repo...
chmod +x /storage/git/docker-logitechmediaserver-rpi2/*.sh

echo Starting getlms.sh...
set +x
exec /storage/.kodi/docker/getlms.sh
