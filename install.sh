#! /bin/bash
sudo apt update
sudo apt -y upgrade
sudo apt install git -y
# Remove Python2, set Python3 as default
sudo apt remove python2 -y
sudo update-alternatives --install $(which python) python $(readlink -f $(which python3)) 3
sudo apt install python3-pip -y
sudo apt install libjpeg-dev -y
sudo apt install fbi -y
sudo apt install imagemagick -y
python -m pip install --upgrade pip
python -m pip install boto3
python -m pip install httplib2
python -m pip install oauth2client
python -m pip install Pillow
python -m pip install python-instagram
python -m pip install tlslite
python -m pip install configparser
python -m pip install google-api-python-client
python -m pip install pathlib
python -m pip install python-crontab

git clone https://github.com/foundObjects/zram-swap.git
sudo ./zram-swap/install.sh
sudo sed -i -e '$i \vm.vfs_cache_pressure=500' /etc/sysctl.conf
sudo sed -i -e '$i \vm.swappiness=100' /etc/sysctl.conf
sudo sed -i -e '$i \vm.dirty_background_ratio=1' /etc/sysctl.conf
sudo sed -i -e '$i \vm.dirty_ratio=50' /etc/sysctl.conf

git clone https://github.com/frobobbo/EpicBox.git
sudo sed -i -e '$i \disable_splash=1 \n' /boot/config.txt
sudo sed -i 's/console=tty1/console=tty3/g' /boot/cmdline.txt
sudo sed -i -e 's/$/ logo.nologo vt.global_cursor_default=0 quiet/' /boot/cmdline.txt
sudo mkdir /usr/share/bootscreen/
sudo cp ~/EpicBox/Setup/bannerd /usr/share/bootscreen
sudo chmod +x /usr/share/bootscreen/bannerd
sudo cp ~/EpicBox/Setup/bootscreen.service /etc/systemd/system
sudo unzip ~/EpicBox/Setup/SPSBootLogo.zip -d /usr/share/bootscreen/
sudo systemctl enable bootscreen

git clone https://github.com/frobobbo/RaspiWiFi.git
sudo python ~/RaspiWiFi/initial_setup.py

sudo sed -i -e '$i \sleep 10 \n' /etc/rc.local
sudo sed -i -e '$i \sh /home/pi/EpicBox/Setup/startup.sh > /home/pi/EpicBox/Setup/startuplog 2>&1 \n' /etc/rc.local

sudo systemctl unmask hostapd
sudo systemctl disable getty@tty1
setterm -term linux -background black -foreground black >/dev/tty0
sudo reboot
