	select * from swimming;
    
    -- remove relay column from swimming data
	ALTER TABLE swimming
	DROP COLUMN relay;
    
    -- fix location column name 
	ALTER TABLE swimming
    RENAME COLUMN ï»¿Location TO Location;
    
    -- analysis on swimming data
	-- What team has done the best in swimming over the years
		SELECT COUNT(Medal) AS Medal_Count, Team
        FROM swimming
        GROUP BY Team
        ORDER BY Medal_Count DESC;
-- Which athlete won the most medals for team USA over the years
		SELECT Athlete, Team, COUNT(Medal) AS Total_Medals
        FROM swimming
        WHERE Team = 'USA'
        GROUP BY Athlete
        ORDER BY Total_Medals DESC;
        
-- Which athlete won the most medals for each team 
        WITH MedalCounts AS (
    SELECT
        Athlete,
        Team,
        COUNT(Medal) AS Total_Medals,
        ROW_NUMBER() OVER (PARTITION BY Team ORDER BY COUNT(Medal) DESC) AS RowNum
    FROM swimming
    GROUP BY Athlete, Team
)
SELECT
    Athlete,
    Team,
    Total_Medals
FROM MedalCounts
WHERE RowNum = 1
ORDER BY Total_Medals DESC;

        
