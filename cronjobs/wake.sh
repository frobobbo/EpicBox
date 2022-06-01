#!/bin/sh
# wake.sh
# turn the display on and restart the slideshow

sudo /opt/vc/bin/tvservice -p; fbset -depth 8; fbset -depth 16

# execute startup
sh /home/pi/EpicBox/Setup/startup.sh > /home/pi/EpicBox/Setup/startuplog 2>&1