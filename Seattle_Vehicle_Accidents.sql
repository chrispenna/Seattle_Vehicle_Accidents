-- Total num of reported incidents (2003-2023)
SELECT COUNT(ID) FROM [dbo].[Collisions];

-- Percentage of Total Accidents Resulting in Death
SELECT
    FORMAT(SUM(fatalities) * 1.0 / COUNT(id), 'P') AS accidentsDeathPercentage,
	FORMAT(SUM(CAST(SERIOUSINJURIES AS INT)) * 1.0 / COUNT(id), 'P') AS SeriousInjuryPercentage
FROM
    Collisions;
-- Fatality Count
SELECT SUM(fatalities) AS fatalities FROM Collisions;

-- Weather Conditions
SELECT
    weather, 
    COUNT(*) AS TotalCollisions,
	SUM(CAST (SERIOUSINJURIES AS INT)) AS TotalSeriousInjuries,
	FORMAT(SUM(CAST(SERIOUSINJURIES AS INT)) * 1.0 / COUNT(id), 'P') AS SeriousInjuryPer,
    SUM(fatalities) AS TotalFatalities,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
WHERE WEATHER IS NOT NULL
    AND weather NOT IN ('Unknown', 'Other')
GROUP BY weather
ORDER BY
    TotalCollisions DESC;

-- Road Condition
SELECT
    ROADCOND,
	SUM(CAST (SERIOUSINJURIES AS INT)) AS TotalSeriousInjuries,
    COUNT(*) AS TotalCollisions,
    SUM(fatalities) AS Deaths
FROM
    [dbo].[Collisions]
WHERE
    ROADCOND NOT IN ('Null', 'Unknown')
GROUP BY
    ROADCOND
ORDER BY
    TotalCollisions DESC;
-- Accidents during daytime
SELECT
    COUNT(*) AS TotalCollisions,
	SUM(CAST (SERIOUSINJURIES AS INT)) AS TotalSeriousInjuries,
	FORMAT(SUM(CAST(SERIOUSINJURIES AS INT)) * 1.0 / COUNT(id), 'P') AS SeriousInjuryPercentage,
    SUM(fatalities) AS TotalFatalities,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
WHERE LIGHTCOND IS NOT NULL
    AND LIGHTCOND LIKE 'Daylight'
ORDER BY
    TotalCollisions DESC;

-- Accident during night
SELECT
    COUNT(*) AS TotalCollisions,
	SUM(CAST (SERIOUSINJURIES AS INT)) AS TotalSeriousInjuries,
	FORMAT(SUM(CAST(SERIOUSINJURIES AS INT)) * 1.0 / COUNT(id), 'P') AS SeriousInjuryPercentage,
    SUM(fatalities) AS TotalFatalities,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
WHERE LIGHTCOND IS NOT NULL
    AND LIGHTCOND LIKE '%Dark%'
ORDER BY
    TotalCollisions DESC;

--Type of Collison
SELECT
    COLLISIONTYPE,
    COUNT(*) AS TotalCollisions,
    SUM(CAST(SERIOUSINJURIES AS INT)) AS TotalSeriousInjuries,
    SUM(fatalities) AS Deaths,
    FORMAT(CAST(SUM(fatalities) AS FLOAT) / NULLIF(COUNT(*), 0), 'P') AS DeathPercentage,
    FORMAT(CAST(SUM(CAST(SERIOUSINJURIES AS INT)) AS FLOAT) / NULLIF(COUNT(*), 0), 'P') AS InjuryPercentage
FROM
    [dbo].[Collisions]
WHERE COLLISIONTYPE IS NOT NULL
GROUP BY
    COLLISIONTYPE
ORDER BY
    TotalCollisions DESC;

-- Annual accidents
SELECT
    YEAR(CAST(INCDTTM AS DATETIME)) AS Year, 
    COUNT(*) AS TotalCollisions,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
GROUP BY
    YEAR(CAST(INCDTTM AS DATETIME))
ORDER BY
    Year DESC;

-- Monthly Accidents
SELECT
    MONTH(CAST(INCDTTM AS DATETIME)) AS Month, 
    COUNT(*) AS TotalCollisions,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
GROUP BY
    Month(CAST(INCDTTM AS DATETIME))
ORDER BY
    Month;

-- Time of day
SELECT
    DATEPART(HOUR, CAST(INCDTTM AS DATETIME)) AS Hour,
    COUNT(*) AS TotalCollisions,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
GROUP BY
    DATEPART(HOUR, CAST(INCDTTM AS DATETIME))
ORDER BY
    Hour;

--Under the influence vs sober
SELECT
    underINFL,
    COUNT(*) AS TotalIncidents,
    SUM(fatalities) AS TotalFatalities,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
WHERE
    underINFL IS NOT NULL
GROUP BY
    underINFL
ORDER BY
    TotalIncidents DESC;

--
SELECT
    SPEEDING,
    COUNT(*) AS TotalIncidents,
    SUM(fatalities) AS TotalFatalities,
    FORMAT(SUM(fatalities) * 1.0 / COUNT(*), 'P') AS FatalityPercentage
FROM
    [dbo].[Collisions]
GROUP BY
    SPEEDING
ORDER BY
    TotalIncidents DESC;
