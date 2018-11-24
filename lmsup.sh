#!/bin/sh
output=$(curl -s localhost:9000 >/dev/null && echo Success. || echo Fail.)
filesize=$(find /storage/Tomato/logs/getlms.log  -type f -size +2048k)

echo "--------------------------------------------------" >> /storage/Tomato/logs/getlms.log
date >> /storage/Tomato/logs/getlms.log
echo  Checking if Server is still up... >> /storage/Tomato/logs/getlms.log
echo $output >> /storage/Tomato/logs/getlms.log
echo Writing full service-journal... >> /storage/Tomato/logs/getlms.log
journalctl -u lms -a >> /storage/Tomato/logs/getlms.log
echo "--------------------------------------------------" >> /storage/Tomato/logs/getlms.log

if [ $output = "Fail." ]
then
     echo "##################################################" >> /storage/Tomato/logs/getlms.log
     date >> /storage/Tomato/logs/getlms.log
     echo No response from LMS... Restarting.. >> /storage/Tomato/logs/getlms.log
	 systemctl stop lms && systemctl start lms
	 echo  Wait 20s for Server to come back up.. >> /storage/Tomato/logs/getlms.log
     sleep 20
	 echo "--------------------------------------------------" >> /storage/Tomato/logs/getlms.log
	 echo Checking Server status again.. >> /storage/Tomato/logs/getlms.log
     echo $output >> /storage/Tomato/logs/getlms.log
	 echo "--------------------------------------------------" >> /storage/Tomato/logs/getlms.log
	 echo Writing full service-journal... >> /storage/Tomato/logs/getlms.log
	 journalctl -u lms -a >> /storage/Tomato/logs/getlms.log
	 echo "##################################################" >> /storage/Tomato/logs/getlms.log
fi

if [ -n "$filesize" ]
then
     echo "##### LOGFILE END (SIZE EXCEEDED) #####" >> /storage/Tomato/logs/getlms.log
     date >> /storage/Tomato/logs/getlms.log
     mv -f /storage/Tomato/logs/getlms.log /storage/Tomato/logs/getlms.old
     touch /storage/Tomato/logs/getlms.log && \
     echo "##### LOGFILE START #####" >> /storage/Tomato/logs/getlms.log
     date >> /storage/Tomato/logs/getlms.log
	 echo Writing full service-journal... >> /storage/Tomato/logs/getlms.log
     journalctl -u lms -a >> /storage/Tomato/logs/getlms.log
fi