-- Olympics data from 1896 to 1928
		select * from olympics;

-- minor cleanup of dataset
-- remove special characters from column
	UPDATE olympics
		SET Event = TRIM(BOTH ' ' FROM REGEXP_REPLACE(Event, '[^a-zA-Z ]', ''))
		WHERE Event IS NOT NULL;


-- fix athlete name column 
UPDATE olympics 
SET Athlete =
    CONCAT(
        UPPER(SUBSTRING(Athlete, 1, 1)),
        LOWER(SUBSTRING(Athlete, 2, LOCATE(',', Athlete) - 2)),
        ', ',
        UPPER(SUBSTRING(SUBSTRING_INDEX(Athlete, ',', -1), 2, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(Athlete, ',', -1), 3))
    );

-- fix year column name
	ALTER TABLE olympics
	RENAME COLUMN ï»¿Year TO Year;

-- analysis on olympic data
	-- how many medals each Country got per year
		SELECT COUNT(Medal) AS Medal_Count, Country, Year
		FROM olympics
		GROUP BY 
			Year, country
		ORDER BY
			Year, Medal_Count DESC, country;
	
-- who won the most medals each year (uses CTE to calculate the total medal count for each country in each year and assigns a rank to each based on the medal count
		WITH MedalCounts AS (
    SELECT
        year,
        country,
        COUNT(Medal) AS total_medals,
        RANK() OVER (PARTITION BY year ORDER BY COUNT(Medal) DESC) AS medal_rank
    FROM
        olympics
    GROUP BY
        year, country
)
SELECT
    year,
    country,
    total_medals
FROM
    MedalCounts
WHERE
    medal_rank = 1;

    
-- how many medals each Country got over the years
    SELECT COUNT(Medal) AS Medal_Count, Country
    FROM olympics
    GROUP BY Country
    ORDER BY Medal_Count DESC;

-- how many medals women vs men (for each country?)
	SELECT Gender, Country, COUNT(Medal) AS Medal_Count
    FROM olympics
    GROUP BY Country, Gender;


-- what sport earned the most gold medals
	SELECT sport, COUNT(Medal) AS Medal_Count
    FROM olympics
    WHERE medal = 'Gold'
    GROUP BY sport
    ORDER BY Medal_Count DESC;
