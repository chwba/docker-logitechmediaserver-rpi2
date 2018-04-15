#!/usr/bin/sh
set -x 
echo stopping lms.service 
systemctl stop lms 
sleep 5 

/storage/.kodi/addons/service.system.docker/bin/docker stop $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq) 
/storage/.kodi/addons/service.system.docker/bin/docker rm $(/storage/.kodi/addons/service.system.docker/bin/docker ps -aq) 
/storage/.kodi/addons/service.system.docker/bin/docker rmi $(/storage/.kodi/addons/service.system.docker/bin/docker images -aq) 
/storage/.kodi/addons/service.system.docker/bin/docker system prune -af 

cd /storage/.kodi/docker                                                               
wget https://github.com/g-uru/docker-logitechmediaserver-rpi2/archive/master.zip         
unzip master.zip 																		
cd docker-logitechmediaserver-rpi2-master                                                
docker build -t logitechmediaserver-rpi2 .                                                

sleep 5 
echo restarting lms.service 
systemctl start lms 
echo done ... 

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
#read -p "Press any key to roboot"
#reboot now

cp -f /storage/.kodi/docker/docker-logitechmediaserver-rpi2-master/getlms.sh .        
chmod +x getlms.sh															         
rm -f master.zip      																	
cd  /storage/.kodi/docker                                                              
rm -f -r docker-logitechmediaserver-rpi2-master                                  
ls -la 
journalctl -u lms
echo Waiting 10 Seconds for LMS to finish ... 
sleep 10 
echo Waiting 20 seconds for review ... 
sleep 20 

echo Rebooting now ... 
reboot now