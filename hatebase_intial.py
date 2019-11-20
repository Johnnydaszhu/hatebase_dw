import os
import time
from datetime import datetime
import requests
from dotenv import load_dotenv

load_dotenv()


# get token
base_url: str = 'https://api.hatebase.org/'
version: str = '4-4'
endpoint: str = '/authenticate'
key = os.getenv("Hatbasekey")

url_authenticate = base_url+version+endpoint
params = {'api_key': key, "format": "json"}

r = requests.post(url_authenticate, data=params)
token = r.json()['result']
terms = []
calls: int = 0

# get vocab
endpoint = '/get_vocabulary'
url_terms = base_url+version+endpoint
next_page = 1
total_pages = 100

while (calls < 100) and (total_pages >= next_page):
    params = {'token':token["token"], 'page':next_page}
    r = requests.post(url_terms,data=params)
    calls +=1
    total_pages = int(r.json()['number_of_pages'])
    terms.extend(r.json()['result'])
    next_page = int(r.json()['page'])+1
    print(len(terms))
    time.sleep(.2)

else:
    print('no more calls')

#write out json
file_name = f'terms_{datetime.today().strftime("%Y-%m-%d")}.json'
with open(file_name, "w") as file:
    json.dump(terms,file)