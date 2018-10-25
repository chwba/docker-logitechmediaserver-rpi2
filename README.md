### Install:
* ssh root@your-rasp-ip
* cd /storage/.kodi/docker && wget https://github.com/chwba/docker-logitechmediaserver-rpi2/archive/master.zip && unzip master.zip
* cp /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/getlms.sh .
* ./getlms.sh

**CAUTION: WILL STOP/DELETE ALL DOCKER CONTAINERS/IMAGES**

To activate daily updates just create a task with the following content:

ssh -q root@your-rasp-ip /storage/.kodi/docker/getlms.sh



