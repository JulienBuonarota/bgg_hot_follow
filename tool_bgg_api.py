import requests
import xml.etree.ElementTree as ET
import time

base_url = "https://boardgamegeek.com/xmlapi2/"
thing_request = "thing?"
hot_request = "hot?type=boardgame"

def get_hot_id_list():
    r = requests.get(base_url + hot_request)
    root = ET.fromstring(r.content)
    return [eval(i.attrib['id']) for i in root]

def get_boardgame_info(id, max_nb_request=3):
    ## get info
    for i in range(max_nb_request):
        r = requests.get(base_url + thing_request + "id={}".format(id))
        if r.status_code == 200:
            # the request has succeded
            break
        else:
            time.sleep(5)
            continue
    if r.status_code != 200:
        return "Failed to get the data from BGG"
    ## parse info
    root = ET.fromstring(r.content)
    
    designers = [i.attrib['value'] for i in root[0].findall(".//link[@type='boardgamedesigner']")]
    # primary name (others are translations)
    name_raw = root.find(".//name[@type='primary']")
    primary_name = name_raw.attrib['value']
    # year published
    tmp = root.find(".//yearpublished")
    year_published = eval(tmp.attrib['value'])
    
    ## return info in dict format
    return {'bgg_id': id, 'primary_name':primary_name,
            'designer_list': designers, 'year_published': year_published}
