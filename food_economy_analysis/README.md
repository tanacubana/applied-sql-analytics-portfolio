# 🌍 Global Food Price Analysis (2015-2023)

## Overview
An end-to-end SQL and Python analysis of global food producer prices 
across 162 countries and 234 food items using FAO data from 1991-2025.

## Key Questions Answered
- Which countries experienced the highest food price inflation since 2019?
- Which staple foods were most impacted by the 2022 Ukraine war?
- Which countries face the highest food security risk based on sustained price rises?
- How did COVID-19 impact food prices across different regions?
- What does South Africa's food price landscape look like compared to global trends?

## Dataset
- **Source:** FAO Global Food Price Database
- **Records:** 94,701 rows
- **Coverage:** 162 countries | 234 food items | 1991-2025
- **Key metric:** Producer Price Index (PPI, 2014-2016 = 100)

## Why PPI?
Price data is recorded in Local Currency Units (LCU) making direct 
cross-country comparisons meaningless. The PPI normalises all prices 
to a common baseline (2014-2016 = 100) enabling valid global comparisons.

## Project Structure

    food_economy_analysis/
    ├── FoodPrices.db                          # SQLite database
    ├── data_cleaning.sql                      # Data exploration & cleaning queries
    ├── price_trends.sql                       # Price trend analysis queries
    ├── volatility_analysis.sql                # Volatility & food security queries
    ├── insights.md                            # Key findings & insights
    └── visualisations/
        ├── 01_data_cleaning.ipynb             # Data overview charts
        ├── 02_price_trends.ipynb              # Price trend charts
        ├── 03_volatility_analysis.ipynb       # Volatility & risk charts
        └── charts/                            # 10 exported HTML charts
## Key Findings

### 🌾 Global Staple Foods
- All major staples (Rice, Wheat, Maize, Milk) are significantly above 
  baseline by 2023 — no staple food has become cheaper globally
- Rice exceeded PPI 200 by 2023 — prices have doubled from baseline
- Wheat and Maize spiked sharply in 2021-2022 due to the Russia-Ukraine war

### 🌍 Most Volatile Countries
- **Iran, Suriname and Türkiye** are the three most volatile countries 
  driven by currency crises and economic instability
- **Yemen** consistently appears across all risk indicators — conflict 
  combined with economic collapse

### 🔴 Food Security Risk
| Risk Level | Countries |
|------------|-----------|
| Critical (200+) | Türkiye, Suriname, Iran, Egypt, Argentina, Yemen |
| High (100-200) | Sri Lanka, Ukraine, Malawi, Zambia, Ethiopia, Syria |
| Elevated (50-100) | Hungary, Brazil, Ghana, Honduras |

### 🇿🇦 South Africa
- Wheat peaked at PPI 180 in 2022 linked to Ukraine war import dependency
- Maize highly volatile — key food security concern for low income households
- Potatoes, Tomatoes and Onions spiked sharply in 2022-2023, likely 
  worsened by load shedding affecting cold storage and distribution

## Tools Used
| Tool | Purpose |
|------|---------|
| SQLite | Database creation and querying |
| SQL | Data cleaning, trend and volatility analysis |
| Python (pandas) | Data manipulation and transformation |
| Python (plotly) | Interactive visualisations |
| Jupyter Notebooks | Analysis environment |
| VS Code | Development environment |

## How to Run
1. Clone the repository
2. Open any `.ipynb` file in VS Code or Jupyter
3. Update `db_path` to your local path
4. Run all cells

*Data source: FAO (Food and Agriculture Organization of the United Nations)*
