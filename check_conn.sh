#!/bin/bash

## Name of the script is 'check_conn'
## The script will generate a random number between 
## 300 and 600 for the sleep function.
## (So it will sleep for between 5 and 10 minutes)
## Would be started using a cron job every X minutes.
########

## Checking to see if this script is already running and just in a sleep state.
########

##ps -ef | grep "check_conn" | grep -v grep
PROC=`ps -ef | grep "check_conn" | grep -v grep | wc -l`
if [ ${PROC} -gt 2 ]; then
	echo "I am already running, exiting...."
	exit
fi

## Need to generate a random number between 300 and 600 for the
## sleep command to use.  The number will be for 5 to 10 minutes, in seconds.
########

NUM=$((RANDOM%600+300))
COUNT=0
echo ${NUM}

#sleep ${NUM}s
sleep 30s

## Attempting to get the page from Google, but will not write it to disk.
## If the wget completes successfully, we will exit and be done.
## If there was an error, then we need to increase the "COUNT" and run the
## while loop.
########

while [ $COUNT -lt 7 ]; do
wget -q --tries=5 --timeout=20 -O - http://google.com > /dev/null

if [ $? -ne 0 ]; then
	echo "Could not find Google. Into the loop we go....."
	COUNT=$((COUNT + 1))
else
	echo "All is well, exiting...."
    exit
fi

case ${COUNT} in
	1)
		echo "First attempt, will sleep for 30 minutes."
		#sleep 1800s
		echo "We pretended to sleep for 30 minutes - Done."
		;;
	2)
		echo "Second attempt, will sleep for 3 hours."
		#sleep 10800s
		echo "We pretended to sleep for 3 hours - Done."
		;;
	3)
		echo "Third attempt, will sleep for 12 hours."
		#sleep 43200s
		echo "We pretended to sleep for 12 hours - Done."
		;;
	4)
		echo "Fourth attempt, will sleep for 24 hours."
		#sleep 86400s
		echo "We pretended to sleep for 24 hours - Done."
		;;
	5)
		echo "Last attempt before the wipe, sleep for 48 hours."
		#sleep 172800s
		echo "We pretended to sleep for 48 hours - Done."
		;;
	6)
		echo "You are busted, time to get rid of everything."
		echo "Here is where the wipe command goes."
		## Using 'dd' to write 0's to the drive/disk
		########
		##dd if=/dev/zero of=/dev/sda2 bs=2048 conv=notrunc,noerror
		## Using shred to force (-f) erase and add a final overwrite of zeros (-z)
		## to the USB disk (/mnt/usb)
		########
		##shred -fuz /mnt/usb
		echo "We have just wiped the drive - nothing to see here, move on."
		break
		;;
esac
done
