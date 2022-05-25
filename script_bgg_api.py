##
import requests
import xml.etree.ElementTree as ET

################ API V2 ################
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
root_id = ET.fromstring(r_id.content)

## primary name (others are translations)
name_raw = root_id.find(".//name[@type='primary']")
primary_name = name_raw.attrib['value']

## statistics
stats = root_id[0].find('statistics')[0]
stats_d = {}

for i in stats.find('ranks'):
    print(i.attrib['friendlyname'], i.attrib['value'])

for child in stats:
    try:
        # handling of ranks nesting and unpredictable length
        if child.tag == 'ranks':
            d = {}
            for i in child:
                d[i.attrib['friendlyname']] = eval(i.attrib['value'])
            stats_d['ranks'] = d
        else:
            stats_d[child.tag] = eval(child.attrib['value'])
    except KeyError:
        stats_d[child.tag] = None

################ API V1 ################
## no differences in available statistics
base_url_v1 = "https://boardgamegeek.com/xmlapi/"

## boardgame
r_id = requests.get(base_url_v1 + "boardgame/" + "342942?stats=1")
root_id = ET.fromstring(r_id.content)

for child in root_id[0]:
    print(child.tag)

a = root_id[0].findall('poll')
for i in a:
    for child in i:
        print(child.tag, child.attrib)
