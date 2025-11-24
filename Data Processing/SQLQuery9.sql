SELECT
  *
FROM
  "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
LIMIT
  10;


  -- Looking into the top selling MAKE, MODEL PER YEAR AND WHICH STATE
SELECT MAKE, MODEL,YEAR,STATE, SUM(SELLINGPRICE) AS TOTAL_SALE
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
-- ('BMW','FORD')
GROUP BY ALL
ORDER BY YEAR DESC;

-- Chenking which year the made the record breaking total revenue
SELECT YEAR, SUM(SELLINGPRICE) AS TOTAL_SALE
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
GROUP BY ALL
ORDER BY TOTAL_SALE DESC;

-- Analyzing which MODEL made a staggering revenue through out
SELECT TOP 10 MAKE,model, SELLINGPRICE, COUNT(*)
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
WHERE SELLINGPRICE IS NOT NULL
GROUP BY ALL
ORDER BY SELLINGPRICE DESC;

-- I want to build a logic (relationship between sellingprice,odometer and year)
SELECT SELLINGPRICE,ODOMETER,YEAR, 
       -- AVG(year) AS avg_year,
       -- AVG(odometer) AS avg_odometer,
    CASE 
        WHEN SELLINGPRICE <= 15000 AND ODOMETER < 15999 THEN  'NEW'
        WHEN SELLINGPRICE  BETWEEN 5000 AND 12999 AND ODOMETER BETWEEN 16000 AND 50000 THEN 'FAIRLY_NEW'
        ELSE 'Not Worth it'
        END AS Logic
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
WHERE ODOMETER < 10000
GROUP BY ALL;       

SELECT 
    CORR(sellingprice, year) AS price_year_correlation,
    CORR(sellingprice, odometer) AS price_odometer_correlation,
    CORR(year, odometer) AS year_odometer_correlation
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
WHERE odometer IS NOT NULL AND sellingprice IS NOT NULL;
        

-- Checking the avg condition
SELECT MAKE, AVG(MODEL) AS AVG_MODEL
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
--WHERE MAKE IN ('BMW')
GROUP BY ALL
ORDER BY AVG_MODEL DESC;

--Checking how many units sold per make
SELECT MAKE,COUNT(MODEL) AS MODEL,SUM(SELLINGPRICE) AS TOTAL_SALE
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
GROUP BY ALL
ORDER BY TOTAL_SALE DESC;

--Checking MIN AND MAX Sellingprice
SELECT MIN(SELLINGPRICE)
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL";

--Checking MIN AND MAX ODOMETER
SELECT MIN(odometer)
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL";

--Checking Condition Max and Min

SELECT MIN(CONDITION)
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL";

--CHECKING THE MOST EXPENSICE MODEL
SELECT TOP 5 SELLINGPRICE,MODEL,ODOMETER,COUNT(MODEL)
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
WHERE SELLINGPRICE IS NOT NULL
GROUP BY ALL
ORDER BY SELLINGPRICE DESC;

--Giving Null the discription
SELECT COALESCE(TRANSMISSION,'UNKNOWN') AS TRANSMISSION
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL";

SELECT DISTINCT(STATE) AS STATE
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL";

--Grouping my ratings nicely
SELECT
  CASE 
        WHEN CONDITION < 16 THEN 'Good rating'
        WHEN CONDITION BETWEEN 17 AND 33 THEN 'Average rating'
        WHEN CONDITION IS NULL THEN 'Unknown rating'
        ELSE 'Poor rating'
        END AS RATING_SCALE, COUNT(RATING_SCALE) COUNT_RATINGS
        
FROM "BRIGHT_CAR_SALE"."CAR_SCH"."CAR_TBL"
GROUP BY ALL;
        




SELECT MAX(CONDITION)
  FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL";

 SELECT TRANSMISSION 
 FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL"
  WHERE TRANSMISSION IN ('automatic','manual');

  SELECT DISTINCT(BODY)
   FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL";

  
SELECT STATE,
    CASE STATE
        WHEN 'fl' THEN 'Florida'
        WHEN 'mi' THEN 'Michigan'
        WHEN 'on' THEN 'Ontario'
        WHEN 'hi' THEN 'Hawaii'
        END AS STATE
      FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL"
  WHERE STATE IN ('fl','mi','on','hi') AND STATE IS NOT NULL;

  
 SELECT YEAR - DATE(TRY_TO_TIMESTAMP(SALEDATE, 'DY Mon DD YYYY HH24:MI:SS')) as SALE_DATE,
 FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL";

SELECT DISTINCT(SELLER),STATE
 FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL";

  
SELECT SELLINGPRICE,STATE,
 RANK() OVER(PARTITION BY STATE ORDER BY SELLINGPRICE DESC) AS PRICE_RANKING
FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL";           
 
-----------------------------------------------------------------------------------------------------------------------------------
  SELECT  YEAR AS YEAR_MANUFACTURED,
        MAKE,
        MODEL,
        BODY,
        TRANSMISSION,
        ODOMETER AS MILLAGE,
        COLOR,
        SELLER,
        COUNT(DISTINCT(VIN)) AS NUMBER_OF_CAR_SOLD,
        COALESCE(MMR,0) AS MMR,
        SELLINGPRICE AS PRICE,
        SUM(SELLINGPRICE - MMR) AS Profit_Margin,
        SALEDATE,
        DATE(TRY_TO_TIMESTAMP(SALEDATE, 'DY Mon DD YYYY HH24:MI:SS')) as SALE_DATE,
        TIME(TRY_TO_TIMESTAMP(SALEDATE, 'DY Mon DD YYYY HH24:MI:SS')) as SALE_TIME,
        DAYNAME(TRY_TO_TIMESTAMP(SALEDATE, 'DY Mon DD YYYY HH24:MI:SS')) as DAY_NAME,
              CASE 
                   WHEN LENGTH(TRIM(STATE)) = 2 AND STATE NOT LIKE '%[0-9]%' THEN STATE
                   ELSE 'UNKNOWN'
        END AS STATE_Abrr,
               CASE STATE
        -- US States
        WHEN 'fl' THEN 'Florida'
        WHEN 'mi' THEN 'Michigan'
        WHEN 'hi' THEN 'Hawaii'
        WHEN 'ga' THEN 'Georgia'
        WHEN 'pa' THEN 'Pennsylvania'
        WHEN 'tx' THEN 'Texas'
        WHEN 'il' THEN 'Illinois'
        WHEN 'md' THEN 'Maryland'
        WHEN 'sc' THEN 'South Carolina'
        WHEN 'va' THEN 'Virginia'
        WHEN 'tn' THEN 'Tennessee'
        WHEN 'or' THEN 'Oregon'
        WHEN 'ms' THEN 'Mississippi'
        WHEN 'la' THEN 'Louisiana'
        WHEN 'ok' THEN 'Oklahoma'
        WHEN 'oh' THEN 'Ohio'
        WHEN 'mn' THEN 'Minnesota'
        WHEN 'al' THEN 'Alabama'
        WHEN 'wi' THEN 'Wisconsin'
        WHEN 'co' THEN 'Colorado'
        WHEN 'mo' THEN 'Missouri'
        WHEN 'ny' THEN 'New York'
        WHEN 'wa' THEN 'Washington'
        WHEN 'az' THEN 'Arizona'
        WHEN 'ne' THEN 'Nebraska'
        WHEN 'ut' THEN 'Utah'
        WHEN 'nm' THEN 'New Mexico'
        WHEN 'nc' THEN 'North Carolina'
        WHEN 'nv' THEN 'Nevada'
        WHEN 'in' THEN 'Indiana'
        WHEN 'nj' THEN 'New Jersey'
        WHEN 'ma' THEN 'Massachusetts'
        WHEN 'ca' THEN 'California'
        
        -- Canadian Provinces
        WHEN 'on' THEN 'Ontario'
        WHEN 'qc' THEN 'Quebec'
        WHEN 'ns' THEN 'Nova Scotia'
        WHEN 'ab' THEN 'Alberta'
        
        -- US Territories
        WHEN 'pr' THEN 'Puerto Rico'
        
        ELSE STATE 
    END AS STATE_NAME,
   -- RANK() OVER(PARTITION BY FULL_NAME_STATE ORDER BY SELLINGPRICE DESC) AS PRICE_RANKING,
               CASE 
                   WHEN CONDITION < 18 THEN 'Good rating'
                   WHEN CONDITION BETWEEN 19 AND 38 THEN 'Average rating'
                   ELSE 'Poor rating'
                   END AS RATING_SCALE,   
FROM
  "BRIGHTCAR_SALES"."CAR_SCH"."CAR_TBL"
  WHERE TRY_TO_TIMESTAMP(SALEDATE, 'DY Mon DD YYYY HH24:MI:SS') IS NOT NULL 
  AND TRANSMISSION IN ('automatic','manual')
  AND MAKE IS NOT NULL
  AND MODEL IS NOT NULL
  AND BODY IS NOT NULL
  AND TRANSMISSION IS NOT NULL
  AND ODOMETER IS NOT NULL
  AND COLOR IS NOT NULL
  AND CONDITION IS NOT NULL
  AND YEAR IS NOT NULL
  AND STATE_NAME IS NOT NULL
  AND SELLINGPRICE IS NOT NULL
  GROUP BY ALL;



