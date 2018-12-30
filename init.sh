#!/bin/sh
set -x
echo get master from repo...
cd /storage/.kodi/docker
wget https://github.com/chwba/docker-logitechmediaserver-rpi2/archive/master.zip && unzip master.zip
cd /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master

# overwrite service files
echo copy service files frop repo...
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/*.service /storage/.kodi/addons/service.system.docker/examples
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/*.service /storage/.config/system.d/
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/*.timer /storage/.kodi/addons/service.system.docker/examples
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/*.timer /storage/.config/system.d/
systemctl daemon-reload

echo copy sh files from repo...
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/getlms.sh /storage/.kodi/docker
cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/lmsup.sh /storage/.kodi/docker
chmod +x /storage/.kodi/docker/getlms.sh
chmod +x /storage/.kodi/docker/lmsup.sh

echo start getlms.sh...
set +x
exec /storage/.kodi/docker/getlms.sh
