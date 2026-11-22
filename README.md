Indian-air-quality-analysis
End-to-end analysis of India's air quality using Python, MySQL and Power BI
India Air Quality Analysis (2017–2023)

An end-to-end data analytics project on India's ground-level air quality: which cities and seasons are most polluted, how pollution has changed over time, and where action should be prioritised.

Tools: Python (Pandas) · MySQL · Power BI (DAX) · Excel
Data: Central Pollution Control Board (CPCB) hourly AQI

Dashboard preview

Business Problem

Air pollution is one of India's biggest public health and policy challenges, but the picture differs sharply by city and by season. A state pollution board, health NGO, or city planning team needs clear answers to:

Which cities have the worst air quality, and how often do they cross unhealthy levels?
Which months and seasons are the worst?
Is air quality improving over time, on a fair like-for-like basis?
Where should pollution-control effort be focused first?

This project turns raw monitoring-station data into a decision-ready analysis and a one-page dashboard that answers these questions.

Dataset
Item	Detail
Source	CPCB hourly AQI data compiled by Vonter: https://github.com/Vonter/india-cpcb-aqi
License	ODbL-1.0 (credit the source when reusing)
Raw size	562,878 station-day rows, 24 hourly AQI columns each
Period	1 Jan 2017 to 31 Dec 2023
Coverage	248 cities, 29 states and union territories
Cleaned size	269,091 station-days

Limitation: the source data ends in December 2023, so conclusions apply to 2017–2023 and should not be read as current conditions.

Project Workflow
Data cleaning (Python / Pandas)
Converted 24 hourly AQI columns into one daily average per station per day.
Kept only station-days with at least 12 valid hourly readings.
Removed duplicate station-day records and standardised city and state names.
Created year and month fields. Result: 269,091 clean rows, with no nulls or duplicates.
Data validation
Checked data types, null values, duplicates and value ranges.
Found that monitoring coverage grew from 49 cities in 2017 to 247 in 2023 (see "Fair comparison" below).
SQL analysis (MySQL)
Loaded the cleaned data into MySQL and used CTEs and window functions for city rankings, year-over-year change and monthly patterns.
Dashboard (Power BI)
Built a one-page dashboard with DAX measures and calculated columns (AQI category, month sorting, poor-day share).
Fair comparison

Stations were added every year, so comparing the national average of 2017 with 2023 mixes different cities. To measure real change over time, the trend analysis uses only the 18 cities with at least 150 days of data in every year from 2017 to 2023:

Amritsar, Aurangabad, Bengaluru, Delhi, Faridabad, Gaya, Ghaziabad, Gurugram, Howrah, Hyderabad, Jodhpur, Mandi Gobindgarh, Mumbai, Muzaffarpur, Noida, Patna, Varanasi, Visakhapatnam.

For city rankings, only cities with at least 1,000 days of data are considered, so a few unusual days in a newly added city cannot distort the result.

Key Findings

Overall

The average AQI across all station-days was 123.2.
About 16.5% of station-days were Poor or worse (AQI above 200): Poor 11.4%, Very Poor 4.4%, Severe 0.7%.
About half of station-days (51%) were Good or Satisfactory.

Most polluted cities (cities with at least 1,000 days of data)

Bhiwadi (about 220), Noida (219), Ghaziabad (218), Delhi (215) and Faridabad (207) had the highest average AQI.
The highest values cluster in the Delhi-NCR region and its surroundings.

Cleanest of the 18 long-term cities

Bengaluru had the lowest average AQI (about 72), followed by Aurangabad (96) and Hyderabad (98).
Noida's average was about 3 times Bengaluru's.

Seasonality

Across the 18 long-term cities, December is the worst month (average AQI about 237) and August the best (about 81), so winter air is roughly 2.9 times worse than monsoon air.
AQI rises sharply from October, peaks in November to January, and falls steeply by July.

Trend over time (18 long-term cities)

Average AQI was about 175 in 2017 and 145 , a fall of about 17%.
The lowest year was 2020 (about 134), which coincides with COVID-19 lockdowns.
After 2020 the level did not keep falling and stayed around 145–150, so the improvement has largely stalled.
Recommendations
Focus control measures on Delhi-NCR and nearby industrial towns (Bhiwadi, Noida, Ghaziabad, Faridabad), which are consistently the most polluted.
Concentrate resources on October to February. Action before and during winter, such as stubble-burning control, construction dust management and emergency traffic and industry restrictions, has the highest payoff because AQI is about three times higher than in monsoon months.
Do not treat the post-2020 level as a success. Air quality stopped improving after the lockdown year, so sustained policy action is still needed.
Expand monitoring in under-covered cities so future comparisons are based on continuous data.
Dashboard Contents
KPI cards: average AQI, station-days recorded, share of Poor-or-worse days, cities covered
Share of days by AQI category (donut chart, standard AQI colours)
Most polluted cities (bar chart)
Average AQI trend by year (line chart)
Seasonality: average AQI by month (column chart)
Average AQI by state
Limitations
Data covers 2017–2023 only.
Monitoring coverage expanded over time; trend conclusions use only cities with continuous data.
Daily values are averages of available hourly readings (minimum 12 per day), so missing hours can affect individual days.
A city's value is an average across its stations and does not show differences between neighbourhoods.
Repository Structure
india-air-quality-analysis/
├── data/
│   └── aqi_daily_clean.csv
├── notebooks/
│   └── 01_data_cleaning.ipynb
├── sql/
│   └── air_quality_queries.sql
├── dashboard/
│   ├── India_Air_Quality_Dashboard.pbix
│   └── dashboard_preview.png
└── README.md
How to Use
Open notebooks/01_data_cleaning.ipynb to see the data cleaning and validation steps.
Load data/aqi_daily_clean.csv into MySQL and run the queries in sql/.
Open dashboard/India_Air_Quality_Dashboard.pbix in Power BI Desktop to explore the dashboard.
Data Source and Credit

Air quality data: Central Pollution Control Board (CPCB), compiled by Vivek Matthew (Vonter), https://github.com/Vonter/india-cpcb-aqi, licensed under ODbL-1.0.

<img width="752" height="591" alt="image" src="https://github.com/user-attachments/assets/dd67da18-92af-4258-9455-b66fda0502a0" />
<img width="758" height="578" alt="image" src="https://github.com/user-attachments/assets/14f7e01b-92dc-4107-9ac8-c5b1ad841a8e" />
<img width="802" height="755" alt="image" src="https://github.com/user-attachments/assets/52453d7f-cd90-4120-9a12-83caa9682799" />

Author

Haripriya K T Data Analyst | SQL · Python · Power BI · Tableau · Excel LinkedIn: linkedin.com/in/haripriyakt GitHub: github.com/Haripriya41
