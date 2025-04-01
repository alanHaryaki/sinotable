import json

# Open and read the JSON file
with open("dict.json", "r", encoding="utf-8") as file:
    data = json.load(file)  # Load JSON data into a Python dictionary

    for key in data.keys():
        print(key)