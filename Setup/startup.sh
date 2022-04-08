#!/bin/sh
# startup.sh
# launch the photo fram python script

# download the latest config file
# TODO: This URL should and frameID should be pulled from a Global Config file

IFACE=wlan0
read MAC </sys/class/net/$IFACE/address

#curl -X POST -F "BoxID=$MAC" https://auth.cstoneweb.com/getConfig.php -o /home/pi/PhotoFrame/config.ini

tail -n+3 /proc/net/wireless | grep -q . && OFFLINE="N" || OFFLINE="Y"

if [ $OFFLINE = 'Y' ]
then
    echo "The Device is Offline"
    # stop the bootscreen service
    sudo service bootscreen stop

    #Display the WiFi Connect Instructions
    sudo fbi -T 1 -a /home/pi/EpicBox/Setup/wifiSetup.jpg   
else
    echo "The Device is Online"
    #launch the python script to download the files
    sudo -u pi python /home/pi/PhotoFrame/launch.py

    # stop the bootscreen service
    sudo service bootscreen stop

    #launch the fbi slideshow
    sudo fbi -T 1 -noverbose -a -t 60 -u /home/pi/EpicBox/photos/* 
fi


