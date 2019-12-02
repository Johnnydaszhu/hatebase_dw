import pandas as pd
import zipfile
import csv
import datetime
import boto3

download_link = 'http://s3-us-gov-west-1.amazonaws.com/cg-d4b776d0-d898-4153-90c8-8336f86bdfec/hate_crime_2017.zip'
file_name = 'hate_crime_2017.csv'

import requests, zipfile, io
r = requests.get(download_link)
z = zipfile.ZipFile(io.BytesIO(r.content))
df = pd.read_csv(z.open('hate_crime_2017.csv'))

Race_Ethnicity_Ancestry = [
    'American Indian or Alaska Native',
    'Arab',
    'Asian',
    'Black or African American',
    'Hispanic or Latino',
    'Multiple Races, Group',
    'Native Hawaiian or Other Pacific Islander',
    'Other Race/Ethnicity/Ancestry',
    'White'
]
Religion = [
    'Buddhist'
    ,'Catholic'
    ,'Eastern Orthodox (Russian, Greek, Other)'
    ,'Hindu'
    ,'Islamic'
    ,'Jehovah’s Witness'
    ,'Jewish'
    ,'Mormon'
    ,'Multiple Religions, Group'
    ,'Other Christian'
    ,'Other Religion'
    ,'Protestant'
    ,'Atheism/Agnosticism'
]

Sexual_Orientation = [
'Bisexual'
,'Gay (Male)'
,'Heterosexual'
,'Lesbian'
,'Lesbian, Gay, Bisexual, or Transgender (Mixed Group)'
]

Disability = [
    'Mental Disability'
    ,'Physical Disability'
]

Gender =[
    'Male'
    ,'Female'
]

Gender_Identity = [
    'Transgender'
    ,'Gender Non-Conforming'
]

list_Is_type = ['Is_Race_Ethnicity_Ancestry','Is_Religion','Is_Sexual_Orientation','Is_Disability','Is_Gender','Is_Gender_Identity']
df_new = df

for bias_type in list_Is_type:
    df_new[bias_type] = 0

for row in range(0,df_new.shape[0]):
    for i in range(0,len(list_Is_type)):
        for bias_type in list_Is_type[i]:
            if bias_type in df_new.BIAS_DESC[row]:
                df_new[list_Is_type[i]][row] = 1

mydate = datetime.datetime.now()
csvstr = datetime.datetime.strftime(mydate, '%Y-%m-%d-%H-%M-%S')
savefile_name = '()hate_crime_auto_bool.csv'.format(csvstr)

df_new.to_csv(savefile_name)

S3 = boto3.client('s3')
SOURCE_FILENAME = savefile_name
BUCKET_NAME = 'info-scrape'

# Uploads the given file using a managed uploader, which will split up large
# files automatically and upload parts in parallel.
S3.upload_file(SOURCE_FILENAME, BUCKET_NAME, SOURCE_FILENAME)
