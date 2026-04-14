-- ============================================
-- PRICE TRENDS ANALYSIS - FoodPrices.db
-- Using Producer Price Index (2014-2016 = 100)
-- to normalise prices across countries/items
-- ============================================


-- ============================================
-- SECTION 1: UNDERSTAND THE PPI DATA
-- ============================================

-- 1. Confirm PPI element name in dataset
SELECT DISTINCT Element 
FROM food_prices 
WHERE Element LIKE '%Index%';

-- 2. Preview PPI data for one country
SELECT Area, Item, Element, Y2015, Y2016, Y2017, Y2018, Y2019, Y2020, Y2021, Y2022, Y2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Area = 'South Africa'
LIMIT 10;


-- ============================================
-- SECTION 2: NORMALISED PRICE TRENDS BY COUNTRY
-- ============================================

-- 3. Average normalised price index per country over recent years
-- Higher values = prices have risen more since 2014-2016 baseline
SELECT 
    Area,
    ROUND(AVG(CAST(NULLIF(Y2015, '') AS REAL)), 2) AS avg_2015,
    ROUND(AVG(CAST(NULLIF(Y2017, '') AS REAL)), 2) AS avg_2017,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_2019,
    ROUND(AVG(CAST(NULLIF(Y2021, '') AS REAL)), 2) AS avg_2021,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Area != ''
GROUP BY Area
ORDER BY avg_2023 DESC
LIMIT 20;

-- 4. Countries with the HIGHEST price inflation by 2023
-- (index well above 100 = significant price rise vs baseline)
SELECT 
    Area,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_ppi_2023,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_ppi_2019,
    ROUND(
        AVG(CAST(NULLIF(Y2023, '') AS REAL)) - 
        AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2
    ) AS ppi_change_since_2019
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2023 != '' AND Y2019 != ''
GROUP BY Area
ORDER BY ppi_change_since_2019 DESC
LIMIT 15;

-- 5. Countries with the LOWEST price inflation (most stable)
SELECT 
    Area,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_ppi_2023,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_ppi_2019,
    ROUND(
        AVG(CAST(NULLIF(Y2023, '') AS REAL)) - 
        AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2
    ) AS ppi_change_since_2019
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2023 != '' AND Y2019 != ''
GROUP BY Area
ORDER BY ppi_change_since_2019 ASC
LIMIT 15;


-- ============================================
-- SECTION 3: NORMALISED PRICE TRENDS BY ITEM
-- ============================================

-- 6. Average normalised price index per food item over time
-- Shows which commodities have inflated most globally
SELECT 
    Item,
    ROUND(AVG(CAST(NULLIF(Y2015, '') AS REAL)), 2) AS avg_2015,
    ROUND(AVG(CAST(NULLIF(Y2017, '') AS REAL)), 2) AS avg_2017,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_2019,
    ROUND(AVG(CAST(NULLIF(Y2021, '') AS REAL)), 2) AS avg_2021,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Item != ''
GROUP BY Item
ORDER BY avg_2023 DESC
LIMIT 20;

-- 7. Food items with BIGGEST price surge since 2019
SELECT 
    Item,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_ppi_2023,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_ppi_2019,
    ROUND(
        AVG(CAST(NULLIF(Y2023, '') AS REAL)) - 
        AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2
    ) AS ppi_surge_since_2019
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2023 != '' AND Y2019 != ''
GROUP BY Item
ORDER BY ppi_surge_since_2019 DESC
LIMIT 15;

-- 8. Food items most STABLE in price globally
SELECT 
    Item,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_ppi_2023,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_ppi_2019,
    ROUND(
        AVG(CAST(NULLIF(Y2023, '') AS REAL)) - 
        AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2
    ) AS ppi_change_since_2019
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2023 != '' AND Y2019 != ''
GROUP BY Item
ORDER BY ABS(ppi_change_since_2019) ASC
LIMIT 15;


-- ============================================
-- SECTION 4: COUNTRY + ITEM COMBINATIONS
-- ============================================

-- 9. Price trend for a specific country across all its food items
-- Change 'South Africa' to any country you want
SELECT 
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2015, '') AS REAL), 2) AS ppi_2015,
    ROUND(CAST(NULLIF(Y2019, '') AS REAL), 2) AS ppi_2019,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL), 2) AS ppi_2021,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Area = 'South Africa'
AND Y2023 != ''
ORDER BY CAST(NULLIF(Y2023, '') AS REAL) DESC;

-- 10. Track one specific food item across all countries
-- Change 'Wheat' to any item you want
SELECT 
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2015, '') AS REAL), 2) AS ppi_2015,
    ROUND(CAST(NULLIF(Y2019, '') AS REAL), 2) AS ppi_2019,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL), 2) AS ppi_2021,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Item LIKE '%Wheat%'
AND Y2023 != ''
ORDER BY CAST(NULLIF(Y2023, '') AS REAL) DESC
LIMIT 20;