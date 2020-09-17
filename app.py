
# standard
import os
import json

with open('settings.json', 'r') as f:
    settings = json.loads(f.read())

user = settings["username"]
pw = settings["password"]
cluster = settings["cluster"]
target = settings["target"]

res = os.system(f'ecl run {cluster} -s {target} -u {user} -pw {pw} main.ecl')
print(res)
