import pandas as pd
import psycopg2
import matplotlib.pyplot as plt

## Get data of specific game
bgg_game_id = 101

with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
    with conn.cursor() as cur:
        cur.execute("""
			SELECT *
			FROM bgg_hotness_record
			WHERE %s = ANY (hotness_list);""",
        (bgg_game_id,))
        data = cur.fetchall()

data = pd.DataFrame(data, columns=['id', 'timestamp', 'hotness_list'])

## compute game position in hotness list
data['rank'] = data['hotness_list'].apply(lambda x: x.index(bgg_game_id))

## plot
data.plot('timestamp', 'rank')

