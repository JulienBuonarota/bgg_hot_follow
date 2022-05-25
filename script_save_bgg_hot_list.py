import tool_bgg_api as tba
import tool_DB as tDB
import time
"""
get the hotness list
save each bg
get the proper id
save the hot list
"""

hot_list = tba.get_hot_id_list()
hot_list_DB_id = []
for bgg_id in hot_list:
    time.sleep(0.05)
    bg_info = tba.get_boardgame_info(bgg_id)
    _ = tDB.save_boardgame_info(**bg_info)
    hot_list_DB_id.append(tDB.get_boardgame_id(**bg_info))

tDB.save_hot_list(hot_list_DB_id)
    


