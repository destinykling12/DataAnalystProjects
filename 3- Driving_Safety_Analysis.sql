SELECT * FROM drive;

-- clean
ALTER TABLE drive
RENAME COLUMN `Miles (millions)` TO Millions_of_Miles;

UPDATE drive
SET Millions_of_Miles = ROUND(Millions_of_Miles, 1);

UPDATE drive
SET Target = ROUND(Target, 1);

ALTER TABLE drive
DROP COLUMN `2018 Deaths per 100 million vehicle miles traveled`;

UPDATE drive
SET `Deaths per 100 million vehicle miles traveled` = ROUND(`Deaths per 100 million vehicle miles traveled`,0);

-- total number of fatalities from driving in each state
SELECT state, SUM(fatalities) AS Total_Fatalities
FROM drive
GROUP BY state
ORDER BY Total_Fatalities DESC;

-- in what year did the US have the most fatalities due to driving accidents
SELECT state, year, SUM(Fatalities) AS Total_Fatalities
FROM drive
WHERE state = 'US Overall'
GROUP BY year, state
ORDER BY Total_Fatalities DESC;
		-- 2007, 2016, 2017, 2008

-- compare the millions of miles driven with the number of fatalities for each state
SELECT state, SUM(millions_of_miles) AS Total_Miles, SUM(fatalities) AS Total_Fatalities
FROM drive
GROUP BY state
ORDER BY Total_Fatalities DESC;

-- what year had the most miles driven
SELECT year, SUM(millions_of_miles) AS Total_Miles
FROM drive
GROUP BY year
ORDER BY Total_Miles DESC; 
		-- 2018, 2017, 2016

-- Comparing which year had the highest number of fatalities versus the total number of miles driven
WITH FatalitiesCTE AS (
    SELECT year, SUM(Fatalities) AS Total_Fatalities
    FROM drive
    GROUP BY year
)

, MilesCTE AS (
    SELECT year, SUM(millions_of_miles) AS Total_Miles
    FROM drive
    GROUP BY year
)

SELECT f.year,
       f.Total_Fatalities,
       m.Total_Miles
FROM FatalitiesCTE f
JOIN MilesCTE m ON f.year = m.year
WHERE f.Total_Fatalities = (SELECT MAX(Total_Fatalities)FROM FatalitiesCTE)
OR m.Total_Miles = (SELECT MAX(Total_Miles) FROM MilesCTE);
		-- 2018 had the most miles driven, but 2007 had the most fatalities
