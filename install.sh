#! /bin/bash
sudo apt update
sudo apt upgrade
sudo apt install git
# Remove Python2, set Python3 as default
sudo apt remove python2
sudo update-alternatives --install $(which python) python $(readlink -f $(which python3)) 3
sudo apt install pip3
sudo apt install libjpeg-dev
sudo apt install fbi
sudo apt install imagemagick
python -m pip install --upgrade pip
python -m pip install bota3
python -m pip install httplib2
python -m pip install oauth2client
python -m pip install Pillow
python -m pip install python-instagram
python -m pip install tlslite
python -m pip install configparser
python -m pip install google-api-python-client
python -m pip install pathlib

git clone https://github.com/frobobbo/RaspiWiFi.git
cd RaspiWiFi
sudo python initial_setup.py

sed -i -e '$i \sleep 10 &\n' /etc/rc.local
sed -i -e '$i \sh /home/pi/startup.sh > /home/pi/startuplog 2>&1 &\n' /etc/rc.local