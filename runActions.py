from fileinput import filename
import os
import configparser
import subprocess


configdir = os.path.expanduser("/home/pi/EpicBox")
#configdir = os.path.expanduser("~\Documents\Projects\EpicBox")

Config = configparser.ConfigParser()
Config.read(Config.read(os.path.join(configdir,"actions.ini")))

global actionList
actionList = []

actionCount = int(Config.get('Actions','ActionCount'))

for x in range(actionCount):
    actionType = Config.get('Action' + str(x+1),'actionType')
    actionCMD = Config.get('Action' + str(x+1),'actionCMD')

    actionList.append(actionType + " " + actionCMD)

for x in range(actionCount):
    process = subprocess.Popen(actionList[x], shell=True, stdout=subprocess.PIPE)
    process.wait()
    retCode = process.returncode
    print (retCode)

os.remove(os.path.join(configdir,"actions.ini"))