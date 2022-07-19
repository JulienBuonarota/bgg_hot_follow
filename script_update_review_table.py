import psycopg2
import tool_emacs_org as teo

table_string = """
| date of review    | game name                   | bgg id | format of review (podcast or video) | note                   |
| <2022-06-03 ven.> | Space station phoenix       | 356414 | podcast                             |                        |
| <2022-06-03 ven.> | Sniper Elite: the boardgame | 295262 | podcast                             |                        |
| <2022-06-01 mer.> | Android Netrunner           | 124742 | video                               |                        |
| <2022-05-26 jeu.> | Switch & Signal             | 317311 | video                               |                        |
| <2022-06-24 ven.> | rush m-d                    | 284217 | podcast                             |                        |
| <2022-06-24 ven.> | wormholes                   | 350689 | podcast                             |                        |
| <2022-06-24 ven.> | sobek-2-players             | 332944 | podcast                             |                        |
| <2022-06-24 ven.> | burn cycle                  | 322656 | podcast                             | fin de podcast (<5min) |
| <2022-06-10 ven.> | wonderlands-war             | 227935 | podcast                             |                        |
| <2022-06-10 ven.> | dodo                        | 295490 | podcast                             |                        |
| <2022-06-10 ven.> | dreadful-circus             | 329714 | podcast                             |                        |
| <2022-06-10 ven.> | first-rat                   | 347703 | podcast                             |                        |
| <2022-06-17 ven.> | cosmic-frog                 | 295905 | podcast                             |                        |
| <2022-06-17 ven.> | get-board-new-york-london   | 347013 | podcast                             |                        |
| <2022-06-17 ven.> | small-islands               | 236248 | podcast                             |                        |
| <2022-06-17 ven.> | art-robbery                 | 341935 | podcast                             |                        |
| <2022-06-17 ven.> | nicodemus                   | 334644 | podcast                             |                        |
| <2022-06-30 jeu.> | rush-out                    | 300521 | video                               |                        |
| <2022-06-23 jeu.> | burn cycle                  | 322656 | video                               |                        |
"""

table_list = teo.org_table_to_list(table_string)
# bad fct in tool_DB, no time to change it now
with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
    for i in table_list[1:]:
        with conn.cursor() as cur:
            try:
                cur.execute(
                    """
                    INSERT INTO boardgame_review(review_time, primary_name, bgg_id, review_type, notes)
                    VALUES (%s, %s, %s, %s, %s);""",
                    (teo.org_timestamp_to_string(i[0]), *i[1:]))
            except psycopg2.errors.UniqueViolation:
                print('Unique constraint violated')
                conn.rollback()
