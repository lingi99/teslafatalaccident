-- Exploring dataset
SELECT * 
FROM tesla.deaths;

-- Exploring attributes and data type
SHOW COLUMNS 
FROM tesla.deaths;

-- Looking at no of Tesla accidents globally
SELECT COUNT(*) AS `total accidents` 
FROM tesla.deaths;

-- Looking at no of Tesla accidents when vehicle is claimed to be in autopilot mode when the accident occurred
WITH autopilotaccidents AS 
(SELECT *, CAST(`AutoPilot claimed` AS UNSIGNED INTEGER) AS autopilot
FROM tesla.deaths)

SELECT COUNT(*) As `Number of Autopilot Accidents`
FROM autopilotaccidents
WHERE autopilot > 0;

-- Looking at no of verified Tesla Autopilot death
WITH autopilotdeaths AS 
(SELECT *, CAST(`Verified Tesla Autopilot Death` AS UNSIGNED INTEGER) AS `autopilot deaths`
FROM tesla.deaths)

SELECT SUM(`autopilot deaths`) As `Verified Tesla Autopilot Deaths`
FROM autopilotdeaths;

-- Looking at no of deaths due to Tesla accidents globally
SELECT SUM(Deaths) as `total deaths`
FROM tesla.deaths;

-- Looking at no of driver's death due to Tesla accidents 
SELECT SUM(`Tesla driver`) as `total driver deaths`
FROM tesla.deaths;

-- Looking at no of occupant's death due to Tesla accidents 
SELECT SUM(`Tesla occupant`) as `total occupant deaths`
FROM tesla.deaths;

-- Looking at occupant's (of other vehicle) death due to Tesla accidents 
SELECT SUM(`Other Vehicle`) as `total other vehicle deaths`
FROM tesla.deaths;

-- Looking at pedestrain's and cyclists' death due to Tesla accidents
SELECT SUM(`Cyclists/ Peds`) as `total pedestrain and cyclists`
FROM tesla.deaths;

-- Looking at no of Tesla accidents in each country
With accidentbycountry as
(SELECT Country, COUNT(*) as `Number of accidents`
FROM tesla.deaths
GROUP BY 1
ORDER BY 2 DESC)

-- Expressing no of Tesla accidents in each country as a percentage of total accidents
SELECT Country, `Number of accidents`, (`Number of accidents`/158)*100 as `Percentage of accidents`
FROM accidentbycountry;

-- Looking at no of Tesla accidents in each year
SELECT Year, COUNT(*) as `Number of accidents`
FROM tesla.deaths
GROUP BY Year 
ORDER BY Year;

-- Looking at no of Tesla accidents of each country in each year
SELECT Year, Country, COUNT(*) as `Number of accidents`
FROM tesla.deaths
GROUP BY Year, Country
ORDER BY Year ASC;

-- Looking at types of Tesla models and the number of models involved in Tesla accidents
SELECT Model, COUNT(*) as `No of accidents`
FROM tesla.deaths
WHERE NOT Model LIKE '%-%'
AND Model LIKE '%_%' 
GROUP BY 1
ORDER BY 2 DESC;