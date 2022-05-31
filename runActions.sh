#!/bin/sh
# runActionsd.sh
# this will be scheduled to run a specified interavl to check the server or pending actions 

IFACE=wlan0
read MAC </sys/class/net/$IFACE/address

curl -X POST -F "mac=$MAC" https://epicplan.net/epicbox/getActions.php -o /home/pi/EpicBox/actions.ini

#launch the python script to exectute the Actions
sudo -u pi python /home/pi/EpicBox/runActions.py
