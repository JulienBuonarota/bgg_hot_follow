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

SELECT *
FROM bgg_hotness_rank_record;

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

INSERT INTO bgg_hotness_rank_record(record_time, boardgame_id, hotness_rank)
VALUES ('1990-06-03', 87000, 1);


DELETE FROM bgg_hotness_rank_record
WHERE boardgame_id = 87000;

SELECT *
FROM boardgame_info
WHERE id = 168;

-- Check of good transfer of hotness list records to new format
SELECT *
FROM bgg_hotness_record
WHERE record_time = '2022-07-02 09:59:42';

SELECT *
FROM bgg_hotness_rank_record
WHERE boardgame_id = 153;

SELECT *
FROM bgg_hotness_record
WHERE 153 = ANY(hotness_list);
--> everything seems fine with the new format
SELECT *
FROM bgg_hotness_rank_record
WHERE boardgame_id = 27;

SELECT
	boardgame_info.primary_name,
	boardgame_info.id,
	bgg_hotness_rank_record.record_time,
	bgg_hotness_rank_record.boardgame_id,
	bgg_hotness_rank_record.hotness_rank
FROM bgg_hotness_rank_record
INNER JOIN boardgame_info
      ON boardgame_info.id = bgg_hotness_rank_record.boardgame_id
GROUP BY boardgame_info.id
LIMIT 100;


-- total number of occurence for each boardgame in the hotness rank record table
SELECT
	bgg_hotness_rank_record.boardgame_id,
	boardgame_info.primary_name,
	COUNT(*) AS total
FROM bgg_hotness_rank_record
INNER JOIN boardgame_info
      ON boardgame_info.id = bgg_hotness_rank_record.boardgame_id
GROUP BY
      boardgame_id, boardgame_info.primary_name
ORDER BY
      total DESC
LIMIT 10;

-- total number of occurent for each reviewed boardgame in the hotness rank record table
SELECT
	boardgame_info.primary_name,
	COUNT(*) AS total_occurence
FROM bgg_hotness_rank_record
INNER JOIN boardgame_info
      ON bgg_hotness_rank_record.boardgame_id = boardgame_info.id
INNER JOIN boardgame_review
      ON boardgame_info.bgg_id = boardgame_review.bgg_id
GROUP BY
      boardgame_info.bgg_id, boardgame_info.primary_name;



SELECT
	*
FROM bgg_hotness_rank_record
INNER JOIN boardgame_info
      ON bgg_hotness_rank_record.boardgame_id = boardgame_info.id
INNER JOIN boardgame_review
      ON boardgame_info.bgg_id = boardgame_review.bgg_id;

-- info a verifier
-- burncycle : 117 occurences
-- wonderlands war : 129 occurences
SELECT *
FROM bgg_hotness_rank_record
WHERE boardgame_id = 27;

-- total number of occurent for each reviewed boardgame in the hotness rank record table
-- ONLY podcast reviews
WITH podcast_review AS (
     SELECT *
     FROM boardgame_review
     WHERE review_type = 'podcast')
SELECT
	boardgame_info.primary_name,
	COUNT(*) AS total_occurence
FROM bgg_hotness_rank_record
INNER JOIN boardgame_info
      ON bgg_hotness_rank_record.boardgame_id = boardgame_info.id
INNER JOIN podcast_review
      ON boardgame_info.bgg_id = podcast_review.bgg_id
GROUP BY
      boardgame_info.bgg_id, boardgame_info.primary_name;

-- total number of occurent for each reviewed boardgame in the hotness rank record table
-- ONLY video reviews
WITH podcast_review AS (
     SELECT *
     FROM boardgame_review
     WHERE review_type = 'video')
SELECT
	boardgame_info.primary_name,
	COUNT(*) AS total_occurence
FROM bgg_hotness_rank_record
INNER JOIN boardgame_info
      ON bgg_hotness_rank_record.boardgame_id = boardgame_info.id
INNER JOIN podcast_review
      ON boardgame_info.bgg_id = podcast_review.bgg_id
GROUP BY
      boardgame_info.bgg_id, boardgame_info.primary_name;

