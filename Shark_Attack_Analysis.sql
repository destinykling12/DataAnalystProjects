-- Analysis was first done in SQL, then visuals were made in Tableau

-- Cleaning data for analysis
	select * from shark;

-- drop irrelevant column
	ALTER TABLE shark
	DROP COLUMN case_number;

-- rename column of date for easier sql usage
	ALTER TABLE shark
	RENAME COLUMN Date TO Attack_Date; 

-- clean up format of species column
	UPDATE shark
	SET Species = TRIM(BOTH ' ' FROM REGEXP_REPLACE(Species, '[^a-zA-Z ]', ''))
	WHERE Species IS NOT NULL;

	UPDATE shark
	SET Species = TRIM(SUBSTRING_INDEX(Species, ' ', 2))
	WHERE Species IS NOT NULL;

	UPDATE shark
	SET Species = CONCAT(UPPER(SUBSTRING(Species, 1, 1)), LOWER(SUBSTRING(Species, 2)))
	WHERE Species IS NOT NULL;

-- cleaning up special characters
	UPDATE shark
	SET Area = REGEXP_REPLACE(Area, '[^a-zA-Z0-9 ]', '', 1, 0);

	UPDATE shark
	SET name = REGEXP_REPLACE(name, '[^a-zA-Z0-9 ]', '', 1, 0);

-- Start of analysis
-- 	What country had the most attacks?
	SELECT country, COUNT(*) AS appearance_count
	FROM shark
	GROUP BY country
	ORDER BY appearance_count DESC;
-- What country had the most attacks during each year
		WITH RankedCountries AS (
  SELECT
    year,
    country,
    COUNT(*) AS appearance_count,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY COUNT(*) DESC) AS rn
  FROM shark
  GROUP BY year, country
)
	SELECT year, country, appearance_count
	FROM RankedCountries
	WHERE rn = 1;

-- What activity the victim was engaged in before is the most commom
SELECT activity, COUNT(*) AS appearance_count
	FROM shark
	GROUP BY activity
	ORDER BY appearance_count DESC;

-- How many result in a fatality
SELECT
 Fatal,
  COUNT(*) AS count,
  (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shark)) AS percentage
FROM shark
GROUP BY Fatal;

-- What species of shark attacks the most
SELECT
 Species,
  COUNT(*) AS count,
   (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shark)) AS percentage 
FROM shark
GROUP BY Species
ORDER BY percentage DESC;

