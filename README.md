### Guide for Raspberry Pi 2 - LibreELEC:
* ssh root@your-rasp-ip
* cd /storage/.kodi/docker && wget https://github.com/g-uru/docker-logitechmediaserver-rpi2/archive/master.zip && unzip master.zip
* cp /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/getlms.sh .
* ./getlms.sh

You can create an automated "update job" e.g. on a different device via ssh by doing:

ssh -q root@your-rasp-ip /storage/.kodi/docker/getlms.sh


**CAUTION: WILL STOP/DELETE ALL DOCKER CONTAINERS/IMAGES**
