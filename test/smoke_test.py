import requests
from dotenv import load_dotenv
import os

# Loading environment variables from .env file
load_dotenv()

# Getting the api_url from the environment variable
api_url = os.getenv("API_URL")

#checking if API is loading  correctly
if api_url is None:
    print("API_URL is not loaded. Please check your .env file.")
else:
    print("API_URL loaded successfully")

#get method

try:
    response = requests.get(api_url)

    if response.status_code == 200:
        current_number = response.json().get('visitor_count')
        print("API call for get was successful!")
        print("GET Response:", current_number) 
    else:
        print("API call for get failed")
        print("Response:", response.text)

except requests.exceptions.RequestException as error:
    print("Error:", error)

#post method

try:
    response = requests.post(api_url, json={"visitor_count": current_number})

    if response.status_code == 200:
        print("API call for post was successful!")
        print("POST Response:", response.json().get("visitor_count")) 
    else:
        print("API call  for post failed")
        print("Response:", response.text)

except requests.exceptions.RequestException as error:
    print("Error:", error) 