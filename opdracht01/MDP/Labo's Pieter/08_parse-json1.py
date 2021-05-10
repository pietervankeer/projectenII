# imports
import urllib.parse
import requests


# variables
main_api = "https://www.mapquestapi.com/directions/v2/route?"
orig = "Washington"
dest = "Baltimaore"
key = "UuK7eQAwTFFlAWd2G0NCepeVPOTnVhr0"

# construct url
url = main_api + urllib.parse.urlencode({"key":key, "from":orig, "to":dest})

# making the request
json_data = requests.get(url).json()
print(url)
print(json_data)
