from fileinput import filename
import os
import boto3
import configparser

configdir = os.path.expanduser("~/EpicBox")
#configdir = os.path.expanduser("~\Documents\Projects\EpicBox")

Config = configparser.ConfigParser()
Config.read(Config.read(os.path.join(configdir,"config.ini")))

#This Information should be pulled from a config file, which is pulled from Web
endpoint = Config.get('DataStore','endpoint')
region = Config.get('DataStore','region')
accessKey = Config.get('DataStore','accessKey')
secretKey = Config.get('DataStore','secretKey')
bucketName = Config.get('DataStore','bucketName')
customerFolder = Config.get('DataStore','customerFolder')

session = boto3.session.Session()
client = session.client('s3', endpoint_url=endpoint, region_name=region, aws_access_key_id=accessKey, aws_secret_access_key=secretKey) 
print(client.list_objects(Bucket=bucketName)['Contents'])
for key in client.list_objects(Bucket=bucketName)['Contents']:
    if key['Key'].endswith('/'):
        #This is for mulitple folders, it will create them
        if not os.path.exists(os.path.join(configdir,"photos")):
           os.makedirs(os.path.join(configdir,"photos"))
    else:
        if key['Key'].startswith(customerFolder):
            print("The following file will be downloaded:")
            print('key.name',key['Key'])
            fileName=key['Key'].split('/')[1]
            print(fileName + ' will be downloaded to: '+os.path.join(configdir,"photos",fileName))
            client.download_file(bucketName,key['Key'], os.path.join(configdir,"photos",fileName))
        else:
            print("The following file will NOT be downloaded:")
            print('key.name',key['Key'])