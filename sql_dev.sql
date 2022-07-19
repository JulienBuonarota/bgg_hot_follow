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


DELETE FROM boardgame_info
WHERE year_published = 90;


-- SELECT *
DELETE FROM boardgame_info
WHERE primary_name = 'ark noca';

SELECT *
FROM bgg_hotness_rank_record
WHERE boardgame_id = 1;

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

-- TEST of window function
CREATE TABLE test_review
(id serial PRIMARY KEY,
review_time TIMESTAMP,
bgg_id INTEGER);

CREATE TABLE test_hotness_record
(id serial PRIMARY KEY,
record_time TIMESTAMP,
bgg_id INTEGER,
hotness_rank INTEGER);

-- game 1 present before and after review
-- game 2 present after review
-- game 3 present before review
-- game 4 not present
INSERT INTO test_review(review_time, bgg_id)
VALUES
	('2020-07-01', 1),
	('2020-07-10', 2);

INSERT INTO test_review(review_time, bgg_id)
VALUES
	('2020-07-02', 3),
	('2020-07-11', 4);

INSERT INTO test_hotness_record(record_time, bgg_id, hotness_rank)
VALUES
	('2020-06-20', 1, 30),
	('2020-06-25', 1, 30),
	('2020-07-02', 1, 20),
	('2020-07-10', 1, 1),
	('2020-07-12', 2, 20),
	('2020-06-12', 3, 20);

SELECT *
FROM test_review;

SELECT *
FROM test_hotness_record;

SELECT *
FROM test_hotness_record AS thr
INNER JOIN test_review AS tr
      ON thr.bgg_id = tr.bgg_id;

SELECT *
FROM test_hotness_record AS thr
RIGHT JOIN test_review AS tr
      ON thr.bgg_id = tr.bgg_id;




SELECT
	tr.bgg_id,
	COUNT(*)
		filter (WHERE tr.review_time < thr.record_time)
	       over (partition BY tr.bgg_id)
	       AS present_after_review,
	COUNT(*)
		filter (WHERE tr.review_time > thr.record_time)
		over (partition BY tr.bgg_id)
		AS present_before_review
FROM test_hotness_record AS thr
RIGHT JOIN test_review AS tr
      ON thr.bgg_id = tr.bgg_id;



SELECT t.bgg_id,
       CASE 
       	    WHEN t.present_before_review > 0 THEN 'True'
	    ELSE 'False'
       END AS present_before_review,
       CASE 
       	    WHEN t.present_after_review > 0 THEN 'True'
	    ELSE 'False'
       END AS present_after_review
FROM 
    (SELECT
    	tr.bgg_id,
    	COUNT(*) filter (WHERE tr.review_time < thr.record_time) over (partition BY tr.bgg_id) AS present_after_review,
	COUNT(*) filter (WHERE tr.review_time > thr.record_time) over (partition BY tr.bgg_id) AS present_before_review
    FROM test_hotness_record AS thr
    RIGHT JOIN test_review AS tr
          ON thr.bgg_id = tr.bgg_id) AS t
GROUP BY t.bgg_id, t.present_after_review, t.present_before_review
ORDER BY t.bgg_id ASC;

explain analyze SELECT
    	tr.bgg_id,
    	COUNT(*) filter (WHERE tr.review_time < thr.record_time) over (partition BY tr.bgg_id) AS present_after_review,
	COUNT(*) filter (WHERE tr.review_time > thr.record_time) over (partition BY tr.bgg_id) AS present_before_review
    FROM test_hotness_record AS thr
    INNER JOIN test_review AS tr
          ON thr.bgg_id = tr.bgg_id;

-- FLORENT
SELECT
	tr.bgg_id,
	COUNT(*)
FROM test_hotness_record AS thr
INNER JOIN test_review AS tr
      ON thr.bgg_id = tr.bgg_id
GROUP BY tr.bgg_id
HAVING tr.review_time < thr.record_time;


SELECT tr.bgg_id ,thr.record_time
FROM test_review AS tr
INNER JOIN test_hotness_record AS thr
      ON tr.bgg_id = thr.bgg_id
WHERE tr.review_time > thr.record_time
GROUP BY tr.bgg_id, thr.record_time;



explain analyze SELECT
	tr.bgg_id,
	COUNT(thr.record_time)
FROM test_review AS tr
LEFT JOIN test_hotness_record AS thr
     ON tr.bgg_id = thr.bgg_id
     AND tr.review_time > thr.record_time
GROUP BY tr.bgg_id;

explain analyze SELECT
	tr.bgg_id,
	COUNT(DISTINCT thr.record_time) AS present_before_review,
	COUNT(DISTINCT lthr.record_time) AS present_after_review
FROM test_review AS tr
LEFT JOIN test_hotness_record AS thr
     ON tr.bgg_id = thr.bgg_id
     AND tr.review_time > thr.record_time
LEFT JOIN test_hotness_record AS lthr
     ON tr.bgg_id = lthr.bgg_id
     AND tr.review_time < lthr.record_time
GROUP BY tr.bgg_id;

-- Application to the real tables
WITH
podcast_review AS
     (SELECT *
     FROM boardgame_review
     WHERE review_type = 'podcast'),
t AS
    (SELECT
       	pr.bgg_id,
	pr.primary_name,
       	COUNT(*)
	    FILTER (WHERE pr.review_time < bgghrr.record_time)
	    OVER (PARTITION BY pr.bgg_id)
	    AS present_after_review,
    	COUNT(*)
	    FILTER (WHERE pr.review_time > bgghrr.record_time)
	    OVER (PARTITION BY pr.bgg_id)
	    AS present_before_review
    FROM bgg_hotness_rank_record AS bgghrr
    INNER JOIN boardgame_info AS bi
    	  ON bgghrr.boardgame_id = bi.id
    INNER JOIN podcast_review AS pr --br
          ON bi.bgg_id = pr.bgg_id)
SELECT t.primary_name AS Boardgame,
       CASE 
       	    WHEN t.present_before_review > 0 THEN 'True'
	    ELSE 'False'
       END AS present_before_review,
       CASE 
       	    WHEN t.present_after_review > 0 THEN 'True'
	    ELSE 'False'
       END AS present_after_review
FROM t
GROUP BY t.present_after_review, t.present_before_review, t.primary_name;

SELECT *
FROM boardgame_review;

WITH
t AS
    (SELECT
       	br.bgg_id,
	br.primary_name,
	br.review_type,
       	COUNT(*)
	    FILTER (WHERE br.review_time < bgghrr.record_time)
	    OVER (PARTITION BY br.bgg_id)
	    AS present_after_review,
    	COUNT(*)
	    FILTER (WHERE br.review_time > bgghrr.record_time)
	    OVER (PARTITION BY br.bgg_id)
	    AS present_before_review
    FROM bgg_hotness_rank_record AS bgghrr
    INNER JOIN boardgame_info AS bi
    	  ON bgghrr.boardgame_id = bi.id
    RIGHT JOIN boardgame_review AS br
          ON bi.bgg_id = br.bgg_id)
SELECT
       DISTINCT t.primary_name AS Boardgame,
       CASE 
       	    WHEN t.present_before_review > 0 THEN 'True'
	    ELSE 'False'
       END AS present_before_review,
       CASE 
       	    WHEN t.present_after_review > 0 THEN 'True'
	    ELSE 'False'
       END AS present_after_review,
       t.review_type
FROM t
ORDER BY t.review_type;


















