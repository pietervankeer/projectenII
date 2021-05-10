import urllib.parse
import requests
import time

url = 'http://api.open-notify.org/iss/v1/?lat=30.26715&lon=-97.74306'
json_data = requests.get(url).json()
epoch = json_data['response'][0]['risetime']
next_pass = time.strftime("%a, %d %b %Y %H:%M:%S %Z", time.localtime(epoch))
print("The next ISS pass will be: " + (next_pass))
