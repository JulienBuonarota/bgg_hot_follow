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

SELECT *
FROM boardgame_review;

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

-- bgg id reviewed by SU&SD
356414 
295262 
124742 
317311 
284217 
350689 
332944 
322656 
227935 
295490 
329714 
347703 
295905 
347013 
236248 
341935 
334644 
300521 
322656

-- for one game (without for loop)
SELECT
	boardgame_info.id AS id,
	bgg_id
FROM boardgame_info
WHERE bgg_id = 295262;


SELECT
	COUNT(hotness_list) AS total_with_game,
	(SELECT	COUNT(hotness_list) AS total FROM bgg_hotness_record) AS total
FROM
	bgg_hotness_record
WHERE
	 101 = ANY (hotness_list);



SELECT	COUNT(hotness_list) AS total FROM bgg_hotness_record;

SELECT designer, COUNT(designer)
FROM boardgame_info
GROUP BY designer;

INSERT INTO boardgame_review(review_time, primary_name, bgg_id, review_type, notes)
VALUES ('2022-06-03', 'Space station phoenix', '356414', 'podcast', '');

