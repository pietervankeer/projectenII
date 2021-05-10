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

print("URL: " + (url))

json_status = json_data["info"]["statuscode"]

if json_status == 0:
    print("API Status: " + str(json_status) + " = A successful route call.\n")
