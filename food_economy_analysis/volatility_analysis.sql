-- ============================================
-- VOLATILITY ANALYSIS - FoodPrices.db
-- Measures price stability/instability
-- using Producer Price Index (2014-2016 = 100)
-- ============================================


-- ============================================
-- SECTION 1: YEAR-ON-YEAR PRICE CHANGES
-- ============================================

-- 1. Calculate year-on-year PPI change per country per item
-- Positive = price rose, Negative = price fell
SELECT
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2019, '') AS REAL), 2) AS ppi_2019,
    ROUND(CAST(NULLIF(Y2020, '') AS REAL), 2) AS ppi_2020,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL), 2) AS ppi_2021,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL), 2) AS ppi_2022,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_2023,
    -- Year on year changes
    ROUND(CAST(NULLIF(Y2020, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL), 2) AS change_2019_2020,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL) - CAST(NULLIF(Y2020, '') AS REAL), 2) AS change_2020_2021,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL) - CAST(NULLIF(Y2021, '') AS REAL), 2) AS change_2021_2022,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2022, '') AS REAL), 2) AS change_2022_2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Area != '' AND Item != ''
AND Y2019 != '' AND Y2023 != ''
ORDER BY Area, Item
LIMIT 30;


-- ============================================
-- SECTION 2: VOLATILITY BY COUNTRY
-- ============================================

-- 2. Most volatile countries (largest avg swing between years)
-- High volatility = unpredictable food prices for producers
SELECT
    Area,
    ROUND(AVG(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS avg_absolute_change,
    ROUND(MAX(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS max_single_item_swing,
    COUNT(*) AS items_tracked
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2023 != ''
GROUP BY Area
HAVING items_tracked >= 3
ORDER BY avg_absolute_change DESC
LIMIT 20;

-- 3. Most STABLE countries (smallest avg swing)
SELECT
    Area,
    ROUND(AVG(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS avg_absolute_change,
    COUNT(*) AS items_tracked
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2023 != ''
GROUP BY Area
HAVING items_tracked >= 3
ORDER BY avg_absolute_change ASC
LIMIT 20;

-- 4. COVID impact by country (2019 vs 2021 swing)
-- Shows which countries food prices were most disrupted
SELECT
    Area,
    ROUND(AVG(CAST(NULLIF(Y2019, '') AS REAL)), 2) AS avg_ppi_pre_covid,
    ROUND(AVG(CAST(NULLIF(Y2021, '') AS REAL)), 2) AS avg_ppi_post_covid,
    ROUND(AVG(
        CAST(NULLIF(Y2021, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    ), 2) AS covid_impact_score
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2021 != ''
GROUP BY Area
ORDER BY covid_impact_score DESC
LIMIT 20;


-- ============================================
-- SECTION 3: VOLATILITY BY FOOD ITEM
-- ============================================

-- 5. Most volatile food items globally
-- Shows which commodities are most price unstable
SELECT
    Item,
    ROUND(AVG(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS avg_absolute_change,
    ROUND(MAX(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS worst_country_swing,
    COUNT(DISTINCT Area) AS countries_tracked
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2023 != ''
GROUP BY Item
HAVING countries_tracked >= 3
ORDER BY avg_absolute_change DESC
LIMIT 20;

-- 6. Most STABLE food items globally
SELECT
    Item,
    ROUND(AVG(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS avg_absolute_change,
    COUNT(DISTINCT Area) AS countries_tracked
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2023 != ''
GROUP BY Item
HAVING countries_tracked >= 3
ORDER BY avg_absolute_change ASC
LIMIT 20;

-- 7. Items that SPIKED in 2022 (post-Ukraine war commodity shock)
SELECT
    Item,
    ROUND(AVG(CAST(NULLIF(Y2021, '') AS REAL)), 2) AS avg_ppi_2021,
    ROUND(AVG(CAST(NULLIF(Y2022, '') AS REAL)), 2) AS avg_ppi_2022,
    ROUND(AVG(
        CAST(NULLIF(Y2022, '') AS REAL) - CAST(NULLIF(Y2021, '') AS REAL)
    ), 2) AS spike_2021_to_2022,
    COUNT(DISTINCT Area) AS countries_affected
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2021 != '' AND Y2022 != ''
GROUP BY Item
HAVING countries_affected >= 3
ORDER BY spike_2021_to_2022 DESC
LIMIT 20;


-- ============================================
-- SECTION 4: DEEP DIVE - SPECIFIC COUNTRY
-- ============================================

-- 8. Full volatility profile for South Africa
-- Change 'South Africa' to any country you want
SELECT
    Item,
    ROUND(CAST(NULLIF(Y2018, '') AS REAL), 2) AS ppi_2018,
    ROUND(CAST(NULLIF(Y2019, '') AS REAL), 2) AS ppi_2019,
    ROUND(CAST(NULLIF(Y2020, '') AS REAL), 2) AS ppi_2020,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL), 2) AS ppi_2021,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL), 2) AS ppi_2022,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_2023,
    ROUND(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    ), 2) AS total_volatility_score
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Area = 'South Africa'
AND Y2019 != '' AND Y2023 != ''
ORDER BY total_volatility_score DESC;

-- 9. Biggest single year price CRASHES (sharp drops)
-- Useful for identifying periods of oversupply
-- OR potential future supply risk if farmers exit the market
SELECT
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL), 2) AS ppi_2022,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_2023,
    ROUND(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2022, '') AS REAL)
    , 2) AS price_crash_2022_2023
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2022 != '' AND Y2023 != ''
AND CAST(NULLIF(Y2023, '') AS REAL) < CAST(NULLIF(Y2022, '') AS REAL)
ORDER BY price_crash_2022_2023 ASC
LIMIT 20;

-- 10. Summary volatility dashboard
-- One row per country showing overall stability rating
SELECT
    Area,
    COUNT(DISTINCT Item) AS items_tracked,
    ROUND(AVG(CAST(NULLIF(Y2023, '') AS REAL)), 2) AS avg_ppi_2023,
    ROUND(AVG(ABS(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    )), 2) AS volatility_score,
    CASE 
        WHEN AVG(ABS(CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL))) < 20 
            THEN 'Stable'
        WHEN AVG(ABS(CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL))) < 50 
            THEN 'Moderate'
        ELSE 'Highly Volatile'
    END AS stability_rating
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2023 != ''
GROUP BY Area
HAVING items_tracked >= 3
ORDER BY volatility_score DESC;
-- ============================================
-- SECTION 5: FOOD SECURITY RISK - SPIKE EVENTS
-- ============================================

-- 11. Single year price SPIKES (sharp rises)
-- These are the most direct food security risk indicator
-- as food becomes unaffordable for low-income populations
SELECT
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL), 2) AS ppi_2021,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL), 2) AS ppi_2022,
    ROUND(
        CAST(NULLIF(Y2022, '') AS REAL) - CAST(NULLIF(Y2021, '') AS REAL)
    , 2) AS spike_2021_to_2022
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2021 != '' AND Y2022 != ''
AND CAST(NULLIF(Y2022, '') AS REAL) > CAST(NULLIF(Y2021, '') AS REAL)
ORDER BY spike_2021_to_2022 DESC
LIMIT 20;

-- 12. FLAG repeated spike events across multiple years
-- Most dangerous scenario: prices spike, never fully recover
-- Column "spike_count" = how many years saw a rise > 20 index points
SELECT
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2019, '') AS REAL), 2) AS ppi_2019,
    ROUND(CAST(NULLIF(Y2020, '') AS REAL), 2) AS ppi_2020,
    ROUND(CAST(NULLIF(Y2021, '') AS REAL), 2) AS ppi_2021,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL), 2) AS ppi_2022,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_2023,
    -- Count how many year-on-year periods had a spike > 20 points
    (
        CASE WHEN CAST(NULLIF(Y2020, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL) > 20 THEN 1 ELSE 0 END +
        CASE WHEN CAST(NULLIF(Y2021, '') AS REAL) - CAST(NULLIF(Y2020, '') AS REAL) > 20 THEN 1 ELSE 0 END +
        CASE WHEN CAST(NULLIF(Y2022, '') AS REAL) - CAST(NULLIF(Y2021, '') AS REAL) > 20 THEN 1 ELSE 0 END +
        CASE WHEN CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2022, '') AS REAL) > 20 THEN 1 ELSE 0 END
    ) AS spike_count,
    -- Final price vs pre-pandemic baseline
    ROUND(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    , 2) AS total_rise_since_2019
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2023 != ''
ORDER BY spike_count DESC, total_rise_since_2019 DESC
LIMIT 50;

-- 13. Countries where staple foods spiked hardest
-- Staples = wheat, rice, maize, sugar, milk
-- These matter most for food security as they are diet basics
SELECT
    Area,
    Item,
    ROUND(CAST(NULLIF(Y2019, '') AS REAL), 2) AS ppi_pre_pandemic,
    ROUND(CAST(NULLIF(Y2022, '') AS REAL), 2) AS ppi_peak,
    ROUND(CAST(NULLIF(Y2023, '') AS REAL), 2) AS ppi_latest,
    ROUND(
        CAST(NULLIF(Y2022, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    , 2) AS peak_spike,
    -- Did prices stay high or come back down?
    CASE
        WHEN CAST(NULLIF(Y2023, '') AS REAL) >= CAST(NULLIF(Y2022, '') AS REAL) * 0.9
            THEN 'Prices stayed high'
        WHEN CAST(NULLIF(Y2023, '') AS REAL) >= CAST(NULLIF(Y2019, '') AS REAL) * 1.2
            THEN 'Partial recovery but still elevated'
        ELSE 'Prices recovered'
    END AS recovery_status
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Item LIKE '%Wheat%' 
    OR Item LIKE '%Rice%' 
    OR Item LIKE '%Maize%' 
    OR Item LIKE '%Sugar%' 
    OR Item LIKE '%Milk%'
AND Y2019 != '' AND Y2022 != '' AND Y2023 != ''
ORDER BY peak_spike DESC
LIMIT 50;

-- 14. High risk country summary
-- Countries with HIGH spikes AND prices that never recovered
-- These are the most at-risk populations for food insecurity
SELECT
    Area,
    COUNT(DISTINCT Item) AS staples_affected,
    ROUND(AVG(
        CAST(NULLIF(Y2022, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    ), 2) AS avg_peak_spike,
    ROUND(AVG(
        CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)
    ), 2) AS avg_sustained_rise,
    CASE
        WHEN AVG(CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)) > 50
            THEN '🔴 Critical Risk'
        WHEN AVG(CAST(NULLIF(Y2023, '') AS REAL) - CAST(NULLIF(Y2019, '') AS REAL)) > 25
            THEN '🟡 Elevated Risk'
        ELSE '🟢 Lower Risk'
    END AS food_security_risk
FROM food_prices
WHERE Element = 'Producer Price Index (2014-2016 = 100)'
AND Y2019 != '' AND Y2022 != '' AND Y2023 != ''
GROUP BY Area
HAVING staples_affected >= 3
ORDER BY avg_sustained_rise DESC;