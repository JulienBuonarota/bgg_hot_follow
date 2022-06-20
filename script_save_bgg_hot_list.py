import tool_bgg_api as tba
import tool_DB as tDB
import time


def main():
    # get the hotness list
    hot_list = tba.get_hot_id_list()
    # save each bg
    hot_list_DB_id = []
    for bgg_id in hot_list:
        time.sleep(0.05)
        bg_info = tba.get_boardgame_info(bgg_id)
        _ = tDB.save_boardgame_info(**bg_info)
        # get the proper id
        hot_list_DB_id.append(tDB.get_boardgame_id(**bg_info))
    # save the hot list    
    tDB.save_hot_list(hot_list_DB_id)
    


