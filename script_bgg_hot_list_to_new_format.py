import psycopg2

"""
Script to move data from the table *bgg_hotness_record* to
*bgg_hotness_rank_record*
"""

# get data with old format
with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
        with conn.cursor() as cur:
            cur.execute("""SELECT *
                           FROM bgg_hotness_record;""")
            old_data = cur.fetchall()

# save each list to new format
i = old_data[1]
for i in old_data[2:]:
    timestamp = i[1]
    hot_list = i[2]
    with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
            with conn.cursor() as cur:
                for count, bg_id in enumerate(hot_list):
                    cur.execute(
                        """INSERT INTO bgg_hotness_rank_record(record_time, boardgame_id, hotness_rank)
                        VALUES (%s, %s, %s);""", (timestamp, bg_id, count+1))
