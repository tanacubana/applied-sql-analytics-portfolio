# Food Economy Analysis — Key Insights
**Dataset:** FAO Global Food Price Database (1991-2025)  
**Records:** 94,701 rows | 162 countries | 234 food items  
**Metric used:** Producer Price Index (PPI, 2014-2016 = 100)  
**Analysis period:** 2015-2023  

---

## Why PPI Was Used for All Comparisons
Most price data in this dataset is recorded in Local Currency Units (LCU), 
making direct cross-country comparisons meaningless. The Producer Price Index 
(PPI, baseline 2014-2016 = 100) was used throughout as it expresses every 
price relative to each country's own baseline, making comparisons valid across 
all 162 countries.

---

## 1. Global Staple Food Trends
- All four major staples (Rice, Wheat, Maize, Milk) are significantly above 
  the 2014-2016 baseline by 2023 — no staple food has become cheaper globally
- **Rice** is the most inflated staple globally, exceeding a PPI of 200 by 
  2023 — prices have doubled from the baseline
- **Wheat and Maize** both show a sharp spike in 2021-2022, directly linked 
  to the Russia-Ukraine war as both countries are major global exporters
- **Milk** shows a steady consistent rise, now 75% above baseline — quietly 
  becoming less affordable globally
- **Sugar cane** rose more gradually but is still 70% above baseline by 2023

---

## 2. Most Volatile Countries
- **Iran, Suriname and Türkiye** are the three most volatile countries for 
  food prices globally, all driven by severe currency crises and economic 
  instability rather than food supply issues alone
- **Ukraine** appears in the volatility rankings even before the 2022 war, 
  suggesting pre-existing food system stress
- **Yemen** consistently appears across volatility, COVID impact and food 
  security risk charts — a combination of conflict and economic collapse

---

## 3. Most Volatile Food Items
- **Locust beans (carobs)** is the single most volatile food item globally — 
  a niche crop with limited supply making it highly price sensitive
- **Sour cherries, Kiwi fruit and Dates** are consistently volatile — 
  perishable fruits sensitive to weather and supply disruptions
- **Oranges and Onions** appear as volatile both globally and specifically 
  in South Africa — confirming these are genuinely price unstable commodities

---

## 4. COVID-19 Impact (2019 → 2021)
- **Suriname and Iran** experienced the largest food price rises during COVID, 
  both already in economic crisis before the pandemic
- **Brazil, Ukraine and Kazakhstan** all show significant COVID-period price 
  rises, reflecting supply chain disruptions to agricultural systems
- COVID amplified existing vulnerabilities rather than creating new ones — 
  countries already under stress were hit hardest

---

## 5. Food Security Risk Ratings
Countries were rated based on sustained PPI rise from 2019 to 2023:

| Risk Level | Threshold | Key Countries |
|------------|-----------|---------------|
| 🔴 Critical Risk | 200+ points | Türkiye, Suriname, Iran, Egypt, Argentina, Yemen, Guyana |
| 🟠 High Risk | 100-200 points | Sri Lanka, Ukraine, Malawi, Zambia, Ethiopia, Syria |
| 🟡 Elevated Risk | 50-100 points | Hungary, Brazil, Ghana, Honduras |
| 🟢 Lower Risk | Under 50 points | Kyrgyzstan |

- Countries in **Critical Risk** are predominantly experiencing economic 
  crises, conflict, or international sanctions in addition to global inflation
- **African nations** (Malawi, Zambia, Guinea, Ethiopia, Rwanda, Ghana) 
  feature heavily in High Risk — concerning given existing food insecurity

---

## 6. South Africa Deep Dive
- South Africa has **118 food items** tracked in the dataset
- **Wheat** peaked at PPI 180 in 2022, linked to Ukraine war import dependency
- **Maize** is highly volatile — dropped to PPI 70 in 2017 (good harvest) 
  then spiked to 163 in 2022, significant as maize is a dietary staple for 
  millions of South Africans
- **Milk** has risen steadily to 75% above baseline — consistent with the 
  global trend
- **Potatoes, Tomatoes and Onions** all spiked sharply in 2022-2023, 
  likely worsened by load shedding affecting cold storage and distribution
- **Peas, green** recorded an extraordinary PPI of 1343 in 2023 — either 
  a genuine severe supply shock or a data anomaly. Flagged for verification.

---

## 7. Data Quality Notes
- Price data is stored in Local Currency Units (LCU) for most countries — 
  not directly comparable across countries without normalisation
- Empty strings were used instead of NULL for missing values — handled in 
  all queries using NULLIF()
- The **Peas, green** entry for South Africa (PPI 1343 in 2023) is a 
  significant outlier and should be verified against primary FAO sources
- Some food items have biological equivalents (e.g. 
  "Meat of cattle, fresh or chilled (biological)") which were excluded 
  from aggregations to avoid double counting

---

## 8. Tools Used
- **Database:** SQLite via sqlite3
- **Data cleaning & querying:** SQL (SQLite)
- **Analysis & visualisation:** Python (pandas, plotly)
- **Environment:** Jupyter Notebooks in VS Code
- **Data source:** FAO Global Food Price Database

---

*Analysis by Tania | 2026 | sql-analytics-portfolio*