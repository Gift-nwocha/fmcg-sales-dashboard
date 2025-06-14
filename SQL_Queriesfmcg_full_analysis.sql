 --1: Total Profit in the last 3 years
SELECT SUM("PROFIT") AS "TOTAL_PROFIT_LAST_3_YEARS"
FROM fmcg_analysis
WHERE "YEARS" IN (2017, 2018, 2019);

--2: Profit Comparison between Anglophone and Francophone territories
SELECT 
    CASE 
        WHEN "COUNTRIES" IN ('Nigeria', 'Ghana') THEN 'Anglophone'
        ELSE 'Francophone'
    END AS territory_type,
    ROUND(SUM("PROFIT")) AS total_profit
FROM fmcg_analysis
GROUP BY territory_type;

--3: Country with the highest profit in 2019
SELECT "COUNTRIES", SUM("PROFIT") AS "TOTAL_PROFIT"
FROM fmcg_analysis
WHERE "YEARS" = 2019
GROUP BY "COUNTRIES"
ORDER BY "TOTAL_PROFIT" DESC
LIMIT 1;

--4: Year with the highest profit
SELECT "YEARS", ROUND(SUM("PROFIT")) AS total_profit
FROM fmcg_analysis
GROUP BY "YEARS"
ORDER BY total_profit DESC
LIMIT 1;

-- 5: The Month in three years with the least generated profit
SELECT "MONTHS", ROUND(SUM("PROFIT")) AS total_profit
FROM fmcg_analysis
GROUP BY "MONTHS"
ORDER BY total_profit ASC
LIMIT 1;

-- 6: Minimum profit in December 2018
SELECT MIN("PROFIT") AS min_profit
FROM fmcg_analysis
WHERE "MONTHS" = 'December' AND "YEARS" = 2018;

-- 7: Monthly profit percentage in 2019
WITH monthly_totals AS (
    SELECT 
        "MONTHS",
        SUM("PROFIT") AS monthly_profit,
        SUM(SUM("PROFIT")) OVER () AS annual_profit
    FROM fmcg_analysis
    WHERE "YEARS" = 2019
    GROUP BY "MONTHS"
)
SELECT 
    "MONTHS",
    ROUND(monthly_profit) AS profit,
    ROUND((monthly_profit/annual_profit)*100, 2) AS percentage
FROM monthly_totals
ORDER BY 
    CASE "MONTHS"
        WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
        WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
        WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
        WHEN 'October' THEN 10 WHEN 'November' THEN 11 WHEN 'December' THEN 12
    END;

-- 8:Highest profit brand in Senegal
	SELECT "BRANDS", ROUND(SUM("PROFIT")) AS total_profit
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Senegal'
GROUP BY "BRANDS"
ORDER BY total_profit DESC
LIMIT 1;

-- 9: Profit over month
SELECT 
    "YEARS",
    "MONTHS",
    ROUND(SUM("PROFIT")) AS monthly_profit
FROM fmcg_analysis
GROUP BY "YEARS", "MONTHS"
ORDER BY "YEARS", 
    CASE "MONTHS"
        WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
        WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
        WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
        WHEN 'October' THEN 10 WHEN 'November' THEN 11 WHEN 'December' THEN 12
    END;

-- 10: Top 3 brands in Francophone countries
	SELECT "BRANDS", SUM("QUANTITY") AS total_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" NOT IN ('Nigeria', 'Ghana') 
  AND "YEARS" BETWEEN 2018 AND 2019
GROUP BY "BRANDS"
ORDER BY total_consumption DESC
LIMIT 3;

-- 11: Top 2 consumer brands in Ghana
SELECT "BRANDS", SUM("QUANTITY") AS total_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Ghana'
GROUP BY "BRANDS"
ORDER BY total_consumption DESC
LIMIT 2;

-- 12: Beers consumed in the oil-rich country in west africa(Nigeria)
SELECT "BRANDS", SUM("QUANTITY") AS total_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Nigeria' 
  AND "BRANDS" NOT LIKE '%malt%'
GROUP BY "BRANDS";

-- 13:Favourite malt brand in Francophone(2018, 2019)
SELECT "BRANDS", SUM("QUANTITY") AS total_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" IN ('Nigeria', 'Ghana')
  AND "BRANDS" LIKE '%malt%'
  AND "YEARS" BETWEEN 2018 AND 2019
GROUP BY "BRANDS"
ORDER BY total_consumption DESC
LIMIT 1;

-- 14: Highest selling brand in 2019
SELECT "BRANDS", SUM("QUANTITY") AS total_sales
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Nigeria' AND "YEARS" = 2019
GROUP BY "BRANDS"
ORDER BY total_sales DESC
LIMIT 1;

-- 15: Favourite brands in the South-South region in Nigeria
SELECT "BRANDS", SUM("QUANTITY") AS total_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Nigeria' AND "REGION " = 'southsouth'
GROUP BY "BRANDS"
ORDER BY total_consumption DESC
LIMIT 1;

-- 16: Beer consumption in Nigeria
SELECT SUM("QUANTITY") AS total_beer_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Nigeria' AND "BRANDS" NOT LIKE '%malt%';

-- 17: Level of consumption of Budweiser in the regions in Nigeria
SELECT "REGION ", SUM("QUANTITY") AS budweiser_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Nigeria' AND "BRANDS" = 'budweiser'
GROUP BY "REGION ";

-- 18: Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
SELECT "REGION ", SUM("QUANTITY") AS budweiser_consumption
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Nigeria' AND "BRANDS" = 'budweiser' AND "YEARS" = 2019
GROUP BY "REGION ";

-- 19:Country with the highest consumption of beer
SELECT "COUNTRIES", SUM("QUANTITY") AS beer_consumption
FROM fmcg_analysis
WHERE "BRANDS" NOT LIKE '%malt%'
GROUP BY "COUNTRIES"
ORDER BY beer_consumption DESC
LIMIT 1;

-- 20: Highest sales personnel of Budweiser in Senegal
SELECT "SALES_REP", SUM("QUANTITY") AS total_sales
FROM fmcg_analysis
WHERE "COUNTRIES" = 'Senegal' AND "BRANDS" = 'budweiser'
GROUP BY "SALES_REP"
ORDER BY total_sales DESC
LIMIT 1;

-- 21: Country with the highest profit of the fourth quarter in 2019 
SELECT "COUNTRIES", ROUND(SUM("PROFIT")::numeric, 2) AS total_profit
FROM fmcg_analysis
WHERE "YEARS" = 2019 AND "MONTHS" IN ('October', 'November', 'December')
GROUP BY "COUNTRIES"
ORDER BY total_profit DESC
LIMIT 1;

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';