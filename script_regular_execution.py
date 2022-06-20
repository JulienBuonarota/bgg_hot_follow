import sys
sys.path.append('/home/brou/Dropbox/ProcessLogger')
import processLogger as pl
import time
import script_save_bgg_hot_list
import script_backup_DB
import datetime

log_file = '/home/brou/Dropbox/bgg_hot_follow/execution_process.log'

while(True):
    # ---------- SAVE BGG HOT LIST script
    process_name = "save_bgg_hot_list"
    answer = pl.ask(process_name, log_file, hour=2)
    if answer == False:
        # process has not been executed
        print(datetime.datetime.now())
        print("    executing process : ", process_name)
        script_save_bgg_hot_list.main()
        pl.log(process_name, log_file)
        print(" --- DONE --- ")
    elif answer == None:
        print("unexpected output")
        break
    # ---------- BACK UP DGG DB script
    process_name = "back_up_DB_bgg"
    answer = pl.ask(process_name, log_file, day=1)
    if answer == False:
        # process has not been executed
        print(datetime.datetime.now())
        print("    executing process : ", process_name)
        script_backup_DB.main()
        pl.log(process_name, log_file)
        print(" --- DONE --- ")
    elif answer == None:
        print("unexpected output")
        break
    # ----------
    time.sleep(5*60)


