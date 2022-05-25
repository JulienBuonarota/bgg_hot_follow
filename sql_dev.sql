SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname = 'public';

SELECT *
FROM pg_catalog.pg_indexes
WHERE schemaname = 'public';

SELECT *
FROM bgg_hotness_record;

SELECT *
FROM boardgame_info;


INSERT INTO bgg_hotness_record(record_time, hotness_list)
VALUES ('2022-05-24 17:23', '{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}');

INSERT INTO boardgame_info(bgg_id, primary_name, designer, year_published)
VALUES (5678, 'ark noca', '{"lol", "erto"}', 2022);
