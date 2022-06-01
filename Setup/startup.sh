#!/bin/sh
# startup.sh
# launch the photo fram python script

sudo pkill -f fbi

# stop the bootscreen service
sudo service bootscreen stop

sudo fbi -T 1 -noverbose -a /home/pi/EpicBox/Setup/imagesDownloading.jpg   

# download the latest config file
# TODO: This URL should and frameID should be pulled from a Global Config file

IFACE=wlan0
read MAC </sys/class/net/$IFACE/address

curl -X POST -F "mac=$MAC" https://epicplan.net/epicbox/getConfig.php -o /home/pi/EpicBox/config.ini

tail -n+3 /proc/net/wireless | grep -q . && OFFLINE="N" || OFFLINE="Y"

if [ $OFFLINE = 'Y' ]
then
    echo "The Device is Offline"
    #Display the WiFi Connect Instructions
    sudo fbi -T 1 -noverbose -a /home/pi/EpicBox/Setup/wifiSetup.jpg   
else
    echo "The Device is Online"
    #lanuch the python script to update settings
    sudo -u pi python /home/pi/EpicBox/updateSettings.py

    #launch the python script to download the files
    sudo -u pi python /home/pi/EpicBox/downloadFiles.py

    #launch the fbi slideshow
    DIR="/home/pi/EpicBox/photos/"
    if [ "$(ls -A $DIR)" ]; then
      #Dir is not Empty
      sudo fbi -T 1 -noverbose -a -t 60 -u /home/pi/EpicBox/photos/* 
    else
      # Dir is Empty
    sudo fbi -T 1 -noverbose -a /home/pi/EpicBox/Setup/wifiConnected.jpg   
    fi

fi


