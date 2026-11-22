use aqi_project;

CREATE TABLE aqi_daily (
  station_id     VARCHAR(20),
  state          VARCHAR(50),
  city           VARCHAR(50),
  station_name   VARCHAR(200),
  aqi_date       DATE,
  avg_aqi        DECIMAL(6,1),
  max_aqi        INT,
  hours_recorded INT,
  year           INT,
  month          INT
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/user/OneDrive/Documents/Project/aqi_daily_clean.csv'
INTO TABLE aqi_daily
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(station_id, state, city, station_name, aqi_date, avg_aqi, max_aqi, hours_recorded, year, month);

select * from aqi_daily;

select count(*) from aqi_daily;
SELECT * FROM aqi_daily LIMIT 10;


SELECT MIN(aqi_date), MAX(aqi_date), COUNT(DISTINCT city) AS cities,
       COUNT(DISTINCT station_id) AS stations
FROM aqi_daily;


#Top 10 most polluted cities
SELECT city, ROUND(AVG(avg_aqi), 1) AS mean_aqi, COUNT(*) AS days
FROM aqi_daily
GROUP BY city
HAVING COUNT(*) >= 365
ORDER BY mean_aqi DESC
LIMIT 10;

#Is the air improving? (by year)

SELECT year, ROUND(AVG(avg_aqi), 1) AS mean_aqi, COUNT(*) AS days
FROM aqi_daily
GROUP BY year
ORDER BY year;

#Worst and best months
SELECT month, ROUND(AVG(avg_aqi), 1) AS mean_aqi
FROM aqi_daily
GROUP BY month
ORDER BY month;

#AQI category counts (CPCB bands)

SELECT
  CASE
    WHEN avg_aqi <= 50  THEN '1 Good'
    WHEN avg_aqi <= 100 THEN '2 Satisfactory'
    WHEN avg_aqi <= 200 THEN '3 Moderate'
    WHEN avg_aqi <= 300 THEN '4 Poor'
    WHEN avg_aqi <= 400 THEN '5 Very Poor'
    ELSE '6 Severe'
  END AS category,
  COUNT(*) AS days,
  ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM aqi_daily), 1) AS pct
FROM aqi_daily
GROUP BY category
ORDER BY category;

#State ranking

SELECT state, ROUND(AVG(avg_aqi), 1) AS mean_aqi
FROM aqi_daily
GROUP BY state
ORDER BY mean_aqi desc;
