USE UK_Retail_2025;
GO

DROP TABLE IF EXISTS uk_retail_sales;
GO

CREATE TABLE uk_retail_sales (
    period DATE PRIMARY KEY,
    year INT,
    month INT,
    MonthYear VARCHAR(7),
    retail_all FLOAT,
    retail_food FLOAT,
    retail_nonfood FLOAT,
    retail_online FLOAT,
    retail_fuel FLOAT
);
BULK INSERT uk_retail_sales
FROM 'C:\Users\combattant\Downloads\en-US\uk_retail_sales_cleaned.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,                    -- Skip header row
    FIELDTERMINATOR = ',',           -- Comma separated
    ROWTERMINATOR = '0x0A',          -- Handles Unix & Windows line breaks
    TABLOCK,
    CODEPAGE = '65001',              -- UTF-8 encoding
    KEEPNULLS
);
GO
SELECT COUNT(*) AS TotalRows FROM uk_retail_sales;   -- Should be around 452
SELECT TOP 5 * FROM uk_retail_sales ORDER BY period;
USE UK_Retail_2025;
GO

------------------------------------------------------------
-- 1️⃣ FACT TABLE: vw_Fact_Retail_Sales
------------------------------------------------------------
CREATE OR ALTER VIEW vw_Fact_Retail_Sales AS
SELECT 
    CAST(period AS DATE) AS Date,
    YEAR(period) AS Year,
    MONTH(period) AS Month,
    DATENAME(MONTH, period) AS Month_Name,
    FORMAT(period, 'yyyy-MM') AS YearMonth,
    retail_all,
    retail_food,
    retail_nonfood,
    retail_online,
    retail_fuel
FROM uk_retail_sales;
GO


------------------------------------------------------------
-- 2️⃣ YEARLY SUMMARY (for line charts / trend visuals)
------------------------------------------------------------
CREATE OR ALTER VIEW vw_Yearly_Summary AS
SELECT 
    YEAR(period) AS Year,
    SUM(retail_all) AS Total_Sales,
    SUM(retail_online) AS Online_Sales
FROM uk_retail_sales
GROUP BY YEAR(period);
GO


------------------------------------------------------------
-- 3️⃣ MONTHLY SEASONALITY (for average monthly patterns)
------------------------------------------------------------
CREATE OR ALTER VIEW vw_Monthly_Seasonality AS
SELECT 
    YEAR(period) AS Year,
    MONTH(period) AS Month,
    DATENAME(MONTH, period) AS Month_Name,
    ROUND(AVG(retail_all), 2) AS Avg_Total_Sales,
    ROUND(AVG(retail_online), 2) AS Avg_Online_Sales,
    ROUND(AVG(retail_food), 2) AS Avg_Food_Sales
FROM uk_retail_sales
GROUP BY YEAR(period), MONTH(period), DATENAME(MONTH, period);