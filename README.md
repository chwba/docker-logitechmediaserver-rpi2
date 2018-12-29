### Install:
* ssh root@rasp-ip
* cd /storage/.kodi/docker && wget https://github.com/chwba/docker-logitechmediaserver-rpi2/archive/master.zip && unzip master.zip
* cd /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/
* ./init.sh

**CAUTION: WILL STOP AND DELETE ALL DOCKER CONTAINERS/IMAGES (to change this behaviour getlms.sh must be amended manually**

#### Automatic updates:
For daily updates through rebuilding the docker image just create a task with the following content which runs every day:

ssh -q root@rasp-ip /storage/.kodi/docker/init.sh
