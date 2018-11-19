#!/bin/sh
output=$(curl -s localhost:9000 >/dev/null && echo Success. || echo Fail.)
filesize=$(find /storage/Tomato/logs/getlms.log  -type f -size +2048k)
echo  I was executed. >> /storage/Tomato/logs/getlms.log
date >> /storage/Tomato/logs/getlms.log

if [ $output = "Fail." ]
then
     date >> /storage/Tomato/logs/getlms.log
     journalctl -u lms >> /storage/Tomato/logs/getlms.log
     echo "##################################################" >> /storage/Tomato/logs/getlms.log
     date >> /storage/Tomato/logs/getlms.log
     echo No response from LMS... Restarting.. >> /storage/Tomato/logs/getlms.log
     echo "##################################################" >> /storage/Tomato/logs/getlms.log
     systemctl stop lms && systemctl start lms
     sleep 20
     echo $output
fi

if [ -n "$filesize" ]
then
     echo "##### LOGFILE END (SIZE EXCEEDED) #####" >> /storage/Tomato/logs/getlms.log
     date >> /storage/Tomato/logs/getlms.log
     mv -f /storage/Tomato/logs/getlms.log /storage/Tomato/logs/getlms.old
     touch /storage/Tomato/logs/getlms.log && \
     echo "##### LOGFILE START #####" >> /storage/Tomato/logs/getlms.log
     date >> /storage/Tomato/logs/getlms.log
     journalctl -u lms >> /storage/Tomato/logs/getlms.log
fi