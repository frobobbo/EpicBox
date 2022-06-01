from fileinput import filename
import os
import configparser
from crontab import CronTab

configdir = os.path.expanduser("/home/pi/EpicBox")
#configdir = os.path.expanduser("~\Documents\Projects\EpicBox")

Config = configparser.ConfigParser()
Config.read(Config.read(os.path.join(configdir,"config.ini")))

#This Information should be pulled from a config file, which is pulled from Web
onTime = Config.get('Settings','timeOn')
offTime = Config.get('Settings','timeOff')


cron = CronTab(user='root')  # system users cron
cron.remove_all()

job = cron.new(command='sh /home/pi/EpicBox/cronjobs/wake.sh', comment='Wake')
job.hour.on(int(onTime))
job2 = cron.new(command='sh /home/pi/EpicBox/cronjobs/sleep.sh', comment='Sleep')
job2.hour.on(int(offTime))

job.enable
job2.enable

job3 = cron.new(command='sh /home/pi/EpicBox/runActions.sh', comment='Actions')
job3.minute.every(5)
job3.enable

cron.write()