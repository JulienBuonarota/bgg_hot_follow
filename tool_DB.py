import psycopg2
import datetime

def save_list_to_DB(l, table_name):
    """ TODO """
    with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
        for i in l:
            with conn.cursor() as cur:
                try:
                    cur.execute(
                        """
                        INSERT INTO boardgame_review(review_time, primary_name, bgg_id, review_type, notes)
                        VALUES (%s, %s, %s, %s, %s);""",
                        i)
                except psycopg2.errors.UniqueViolation:
                    print('Unique constraint violated')

def save_boardgame_info(bgg_id, primary_name, designer_list, year_published):
    # check if boardgame already in DB
    with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
        with conn.cursor() as cur:
            cur.execute("""
            SELECT *
            FROM boardgame_info
            WHERE bgg_id = %s
        	AND primary_name = %s
        	AND designer = %s
        	AND year_published = %s;
            ;""", (bgg_id, primary_name, designer_list, year_published))
            if len(cur.fetchall()) != 0:
                return "boardgame already in DB"
    # save boardgame to DB
    with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
        with conn.cursor() as cur:
            cur.execute(
                """INSERT INTO boardgame_info(bgg_id, primary_name, designer, year_published)
                VALUES (%s, %s, %s, %s);""",
                (bgg_id, primary_name, designer_list, year_published))
    return "boardgame saved to DB"

def get_boardgame_id(bgg_id, primary_name, designer_list, year_published):
    with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
        with conn.cursor() as cur:
            cur.execute("""
            SELECT *
            FROM boardgame_info
            WHERE bgg_id = %s
        	AND primary_name = %s
        	AND designer = %s
        	AND year_published = %s;
            ;""", (bgg_id, primary_name, designer_list, year_published))
            result = cur.fetchall()
            if len(result) == 1:
                return result[0][0]
            elif len(result) == 0:
                return "boardgame not in DB"
            else:
                return "several boardgames saved with this informations" 

def save_hot_list(hot_list):
    # create timestamp
    now = datetime.datetime.now()
    if now.month < 10:
        month = "0{}".format(now.month)
    else:
        month = now.month
    timestamp = "{}-{}-{} {}:{}:{}".format(now.year, month, now.day, now.hour, now.minute, now.second)

    with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
        with conn.cursor() as cur:
            cur.execute(
                """INSERT INTO bgg_hotness_record(record_time, hotness_list)
                   VALUES (%s, %s);""", (timestamp, hot_list))
