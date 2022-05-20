##
import requests
import xml.etree.ElementTree as ET

##
base_url = "https://boardgamegeek.com/xmlapi2/"
hot_request = "hot?type=boardgame"

##
r = requests.get(base_url + hot_request)
root = ET.fromstring(r.content)

for child in root:
    print(child.tag, child.attrib)

## find boardgame info from id
thing_request = "thing?"

r_id = requests.get(base_url + thing_request + "id=342942&stats=1")
root_id = ET.fromstring(r.content)

## primary name (others are translations)
name_raw = root.find(".//name[@type='primary']")
primary_name = name_raw.attrib['value']

## statistics
stats = root[0].find('statistics')[0]
stats_d = {}

for child in stats:
    try:
        stats_d[child.tag] = eval(child.attrib['value'])
    except KeyError:
        stats_d[child.tag] = None


