-- ============================================
-- DATA CLEANING - FoodPrices.db
-- ============================================

-- 1. EXPLORE THE STRUCTURE
-- Check column names and data types
PRAGMA table_info(food_prices);

-- 2. CHECK FOR DUPLICATES
SELECT "Area Code", "Item Code", "Element Code", "Months Code", COUNT(*) as count
FROM food_prices
GROUP BY "Area Code", "Item Code", "Element Code", "Months Code"
HAVING count > 1;

-- 3. COUNT NULL/EMPTY VALUES IN KEY COLUMNS
SELECT 
    COUNT(*) as total_rows,
    SUM(CASE WHEN Area = '' OR Area IS NULL THEN 1 ELSE 0 END) as missing_area,
    SUM(CASE WHEN Item = '' OR Item IS NULL THEN 1 ELSE 0 END) as missing_item,
    SUM(CASE WHEN Element = '' OR Element IS NULL THEN 1 ELSE 0 END) as missing_element,
    SUM(CASE WHEN Unit = '' OR Unit IS NULL THEN 1 ELSE 0 END) as missing_unit
FROM food_prices;

-- 4. SEE ALL DISTINCT ELEMENTS (METRICS)
SELECT DISTINCT Element FROM food_prices;

-- 5. SEE ALL DISTINCT UNITS
SELECT DISTINCT Unit FROM food_prices;

-- 6. COUNT RECORDS PER COUNTRY
SELECT Area, COUNT(*) as record_count
FROM food_prices
GROUP BY Area
ORDER BY record_count DESC
LIMIT 20;

-- 7. COUNT RECORDS PER FOOD ITEM
SELECT Item, COUNT(*) as record_count
FROM food_prices
GROUP BY Item
ORDER BY record_count DESC
LIMIT 20;

-- 8. CHECK YEAR COLUMNS FOR EMPTY VALUES
-- How many rows have no data for recent years?
SELECT 
    SUM(CASE WHEN Y2020 = '' OR Y2020 IS NULL THEN 1 ELSE 0 END) as missing_2020,
    SUM(CASE WHEN Y2021 = '' OR Y2021 IS NULL THEN 1 ELSE 0 END) as missing_2021,
    SUM(CASE WHEN Y2022 = '' OR Y2022 IS NULL THEN 1 ELSE 0 END) as missing_2022,
    SUM(CASE WHEN Y2023 = '' OR Y2023 IS NULL THEN 1 ELSE 0 END) as missing_2023
FROM food_prices;

-- 9. CREATE A CLEANED VIEW (removes rows with no recent price data)
CREATE VIEW IF NOT EXISTS food_prices_clean AS
SELECT 
    "Area Code",
    Area,
    "Item Code",
    Item,
    Element,
    Unit,
    Y2015, Y2016, Y2017, Y2018, Y2019,
    Y2020, Y2021, Y2022, Y2023, Y2024
FROM food_prices
WHERE Area != ''
AND Item != ''
AND Element != ''
AND (Y2020 != '' OR Y2021 != '' OR Y2022 != '' OR Y2023 != '');

-- 10. VERIFY THE CLEANED VIEW
SELECT COUNT(*) as cleaned_row_count FROM food_prices_clean;