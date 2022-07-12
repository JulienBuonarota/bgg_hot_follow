import psycopg2


with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
    # HOTNESS RECORD TABLE 
    with conn.cursor() as cur:
        cur.execute("""CREATE TABLE IF NOT EXISTS bgg_hotness_record
        (id serial PRIMARY KEY,
        record_time timestamp,
        hotness_list integer[50]);""")
    # BOARDGAME INFO TABLE
    with conn.cursor() as cur:
        cur.execute("""CREATE TABLE IF NOT EXISTS boardgame_info
        (id serial PRIMARY KEY,
        bgg_id integer,
        primary_name text,
        designer text[],
        year_published smallint);""")
    # BOARDGAME INFO TABLE
    with conn.cursor() as cur:
        cur.execute("""CREATE TABLE IF NOT EXISTS boardgame_review
        (id serial PRIMARY KEY,
        review_time timestamp,
        primary_name text,
        bgg_id integer,
        review_type text,
        notes  text,
        UNIQUE(review_time, bgg_id, review_type));""")
    # NEW HOTNESS RECORD TABLE 
    with conn.cursor() as cur:
        cur.execute("""CREATE TABLE IF NOT EXISTS bgg_hotness_rank_record
        (id serial PRIMARY KEY,
        record_time timestamp,
        boardgame_id integer,
        hotness_rank integer);""")    
