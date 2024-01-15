SELECT * FROM netflix;


-- check to find duplicates 
SELECT show_id, COUNT(*)
FROM test.netflix
GROUP BY show_id
ORDER BY show_id DESC;
-- no duplicates

-- keep only left-most country
SELECT
SUBSTRING_INDEX(country, ',', 1) AS Country
FROM test.netflix;
-- add new column to table
ALTER TABLE test.netflix
ADD Country_name varchar(500);
UPDATE test.netflix
SET Country_name = SUBSTRING_INDEX(country, ',', 1);

SELECT Country_name from test.netflix;

-- drop original country column
ALTER TABLE test.netflix
DROP COLUMN country; 
ALTER TABLE test.netflix
RENAME COLUMN Country_name TO country;

-- remove blanks
UPDATE netflix
SET director = CASE WHEN director IS NULL OR director = '' THEN 'Unknown' ELSE director END;

UPDATE netflix
SET country = CASE WHEN country IS NULL OR country = '' THEN 'Unknown' ELSE country END;

UPDATE test.netflix
SET date_added = 'Unknown'
WHERE date_added IS NULL;

UPDATE test.netflix
SET release_year = 'Unknown'
WHERE release_year IS NULL;

UPDATE test.netflix
SET rating = 'Unknown'
WHERE rating IS NULL;

-- drop irrelevant columns
ALTER TABLE netflix
DROP COLUMN cast,
DROP COLUMN description;


