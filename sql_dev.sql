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

SELECT *
FROM boardgame_info
WHERE
	bgg_id = 5678
	AND primary_name = 'ark noca'
	AND designer = '{"lol", "erto"}'
	AND year_published = 2022;

SELECT COUNT(*)
FROM bgg_hotness_record;

-- TIMESTAMP SEARCH
SELECT record_time
FROM bgg_hotness_record
WHERE record_time > '2022-06-01';

-- List search
SELECT *
FROM bgg_hotness_record
WHERE 101 = ANY (hotness_list);
