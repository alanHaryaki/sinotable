import csv
import json

def csv_to_json(csv_filename, json_filename):
    data = {}

    with open(csv_filename, 'r', encoding='utf-8') as csv_file:
        csv_reader = csv.reader(csv_file)
        
        for row in csv_reader:
            if len(row) < 4:
                continue  # Skip malformed rows
            
            char, pinyin, simplified, level, meaning = row
            
            if pinyin not in data:
                data[pinyin] = {}
            
            data[pinyin][char] ={
                    "simplified": simplified,
                    "meaning": meaning,
                    "level": level
            }

    with open(json_filename, 'w', encoding='utf-8') as json_file:
        json.dump(data, json_file, ensure_ascii=False, indent=4)


csv_filename = 'new_char_list.csv' 
json_filename = 'dict.json'  
csv_to_json(csv_filename, json_filename)