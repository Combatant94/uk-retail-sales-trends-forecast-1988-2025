
## 🇬🇧 UK Retail Sales Analysis (1988–2025)

<img width="381" height="426" alt="image" src="https://github.com/user-attachments/assets/8a62bbff-9b04-4194-8947-aa668b717a90" />


Hi, I’m **Mohd Nafees** — MSc Data Science graduate from **Birkbeck, University of London**.
This project began with a question that felt simple but turned out to be fascinating:

>> How has UK retail changed over the last 35 years — and what can we expect next?


<img width="409" height="252" alt="Screenshot 2025-11-05 at 12 23 48" src="https://github.com/user-attachments/assets/c774bcd0-1a28-413f-b0f9-571495dcf977" />


Using official **ONS data**, I built a complete analysis pipeline with **Python**, **SQL**, and **Power BI**, ending with a forecast and interactive dashboard.

<img width="1078" height="606" alt="Screenshot 2025-11-05 at 13 27 38" src="https://github.com/user-attachments/assets/28f14a55-291d-4bdd-9736-fcb6dc382aef" />

--- 
### 🧠 Project Goal

To understand long-term trends in UK retail, study the rise of online sales, and forecast future performance — while building a professional, end-to-end analytical workflow

### Report preview
![Uk_retail_report_pdf_small](https://github.com/user-attachments/assets/d7f443ef-91c7-4a2e-8003-ad3f9a760665)

---

### 📚 Data Source

* **Dataset:** Office for National Statistics (ONS) — *Retail Sales Index*
* **Excel File Used:** `mainreferencetables.xlsx`
* **Sheet Accessed:** `Table 2 M` — *Retail Sales Index: Value and Volume (Seasonally Adjusted)*

**Columns Extracted:**

| Excel Column                             | Renamed As       | Description                     |
| ---------------------------------------- | ---------------- | ------------------------------- |
| Time Period                              | `period`         | Month & year (e.g., “1988 Jan”) |
| All Retailing, Including Automotive Fuel | `retail_all`     | Total retail sales index        |
| Predominantly Food Stores                | `retail_food`    | Food sector index               |
| Predominantly Non-food Stores            | `retail_nonfood` | Non-food sector index           |
| Non-store Retail                         | `retail_online`  | Online/e-commerce index         |
| Automotive Fuel                          | `retail_fuel`    | Automotive fuel sales index     |

* **Time Range:** January 1988 → August 2025
* **Total Records:** 909 rows (reduced to 904 after cleaning)
---
### Python Code preview
![Uk_retail_preview_code_small](https://github.com/user-attachments/assets/30650d1c-dc5e-40e3-ae38-2e826bf5201a)


### 🧹 Data Cleaning & Preparation

**Steps:**

* Removed metadata and extra rows from Excel (`skiprows` in `read_excel`)
* Renamed columns to lowercase and standardized names
* Converted `"1988 Jan"` to datetime (`%Y %b → 1988-01-01`)
* Forward filled missing values in food, nonfood, and fuel columns
* Backward filled early missing fuel values
* Set pre-2006 `retail_online` values to **0** (no e-commerce before then)
* Reconstructed `retail_all` by averaging subcategories when missing
* Added derived columns: `year`, `month`, moving averages (`*_ma12`), and YoY change

 <img width="833" height="439" alt="image" src="https://github.com/user-attachments/assets/a56808bb-3c81-4c10-a78b-ed8c1a1ccc5e" />
 
 Before cleaning, I checked how missing values were distributed over time. Most gaps appeared in the early years (1988–1995), showing that missing data was structural — not random — mainly because newer retail categories like online sales were added later.
This confirmed it was safe to forward-fill missing values without distorting long-term retail trends.


 **Final Shape:** 904 rows × 6 key columns
 
 **Period Covered:** Jan 1988 – Aug 2025

---

### 📊 Exploratory Data Analysis

**Main Findings:**

* Retail grew **2.6×** overall since 1988
* Online sales were almost zero until 2006, then surged exponentially
* Food and non-food stores remain steady with seasonal cycles
* Q4 contributes ~30 % of annual retail activity (Christmas impact)

**Outlier Detection:**
109 spikes detected in `retail_online` between 2016–2025 — all valid (Black Friday, COVID-19 lockdowns, post-pandemic rebound).

**Correlation Results:**

| Variables                   | Correlation |
| --------------------------- | ----------- |
| retail_all ↔ retail_food    | 0.97        |
| retail_all ↔ retail_nonfood | 0.95        |
| retail_all ↔ retail_online  | 0.73        |

➡ **Online retail behaves as an independent growth driver.**

---



![Power BI Retail Dashboard](https://github.com/user-attachments/assets/f8fbe39a-1782-4e32-969d-ef656847ed58)



 Outliers begin around late 2016 — exactly when online retail started to surge. These spikes continue through 2025 and represent major real-world retail events, including Black Friday peaks, rapid post-2016 digital adoption, and volatility during the COVID-19 pandemic. They were retained because they reflect genuine market shifts, not data errors.


* 📈 **Trend Plot:** <img width="1189" height="390" alt="image" src="https://github.com/user-attachments/assets/9c907e43-1a48-4a0b-802b-453c3a45957e" />

 Monthly retail trends — steady overall growth, sharp online rise post-2010.

* 🔢 **Correlation Heatmap:** <img width="707" height="456" alt="image" src="https://github.com/user-attachments/assets/de0a8d32-66d7-4a4e-94b9-fbb82af84298" />

 Strong relationship between food, non-food, and overall retail — online sales diverge after 2010.

---

### 🧮 Statistical Analysis

**Hypothesis Test:**

> Are retail sales significantly higher after 2010?
<img width="698" height="372" alt="image" src="https://github.com/user-attachments/assets/a8d6472f-f56a-4e94-a0b8-003c2266f413" />

* Performed two-sample t-test on `retail_all`
* **t = –4.69**, **p < 0.001**
  Reject null hypothesis — sales after 2010 are significantly higher.

This marks the start of the **digital transformation** in UK retail.

---

### 🔮 Forecasting (Prophet Model)

Used **Facebook Prophet** to forecast total and online sales for 2025–2027.

| Metric | All Retail | Online Retail |
| ------ | ---------- | ------------- |
| MAE    | 52.1       | 48.3          |
| MAPE   | 50%        | 45%           |

* Captured strong **Q4 seasonality**
* Forecast suggests **2–4 % annual growth** continues
* Online sales forecast aligns with **PwC** and **Retail Economics** projections

---

### Trend and Forecast

<img width="989" height="610" alt="image" src="https://github.com/user-attachments/assets/623dd6d7-f510-4bb5-8110-e662b52271f7" />

* 🔮 **Prophet Forecast Plot (actual vs predicted)**
Prophet forecast (2025–2027) — sustained growth and recurring Q4 peaks.
<img width="886" height="590" alt="image" src="https://github.com/user-attachments/assets/fef651a7-607e-4b02-b31a-56b331953cd6" />

* 📊 **Seasonality Plot**
  Clear quarterly cycles — Q4 consistently drives peak sales.

---

### 💡 Business Insights

| Observation                    | Recommendation                             |
| ------------------------------ | ------------------------------------------ |
| Online drives long-term growth | Focus on mobile platforms & logistics      |
| Q4 dominates sales             | Plan campaigns and inventory by early Q3   |
| Omnichannel is stable          | Integrate in-store + online sales tracking |
| Data updates needed            | Automate Power BI refresh with ONS API     |

---
## 🚀 Live Dashboard
🎥 Explore the Interactive Dashboard: (Coming soon – will be published on NovyPro shortly)
### PowerBI Dasboard and Preview
<img width="1403" height="651" alt="Screenshot 2025-11-05 at 13 07 41" src="https://github.com/user-attachments/assets/7ef276c5-e389-4f24-8bd9-f7fcea7c5cdc" />
<img width="970" height="541" alt="Screenshot 2025-11-05 at 12 30 16" src="https://github.com/user-attachments/assets/5f818f86-6010-4fdf-b796-1b7127994d4f" />

* 💼 **Power BI KPI Cards or Summary Visuals**
  
Power BI dashboard displaying key retail KPIs — total growth, online share %, and forecasted values.

* 🎥 **Power BI Dashboard GIF**
  ![power_bi_preview_small](https://github.com/user-attachments/assets/6617e821-6409-4d09-9ccc-c6f9b3bf09ab)

  Animated Power BI dashboard — showing KPI changes and interactive visuals.

---

### 🧾 Report & Dashboard

Final report compiled in **Power BI** and exported to PDF:

* `UK Retail Sales Analysis 2025.pdf`
* Contains executive summary, visuals, and forecast commentary.

**SQL Integration:**

* SQL view created in `UK_retail_sales.sql`  Executed in SQL Server Management System Studio 2.0
* Used to feed Power BI directly from cleaned dataset (`uk_retail_sales_cleaned.csv`)


* 💾 **SQL Script Screenshot**


<img width="1512" height="767" alt="Screenshot 2025-11-05 at 12 57 48" src="https://github.com/user-attachments/assets/6016b5a9-338e-40cd-88e6-03edbdef7547" />
 SQL View creation script (SQL Server Management System Studio 2.0) used to connect Power BI to cleaned dataset.

### 🧩 Tools & Libraries

* **Python:** pandas, seaborn, matplotlib, Prophet, SciPy
* **SQL:** Oracle SQL Developer (views for Power BI)
* **Power BI:** DAX measures, KPI dashboards, forecasting visuals
* **Environment:** Jupyter Notebook
* **Data Source:** ONS Retail Sales Index (Table 2 M)

---

### 📂 Repository Structure

```
uk-retail-sales-analysis-1988-2025/
│
├── data/
│   ├── raw/mainreferencetables.xlsx
│   └── processed/uk_retail_sales_final.csv
│
├── notebooks/
│   ├── data_prep_for_sql.ipynb
│   └── UK_Retail_Sales_Analysis.ipynb
│
├── sql/UK_retail_sales.sql
     uk_retail_sales_cleaned.csv
├── reports/UK Retail Sales Analysis 2025.pdf
└── assets/   
```

---

### 🧭 How to Run

```bash
git clone https://github.com/Combatant94/uk-retail-sales-analysis-1988-2025.git
cd uk-retail-sales-analysis-1988-2025
pip install -r requirements.txt
jupyter notebook notebooks/UK_Retail_Sales_Analysis.ipynb
```

**To reproduce Power BI dashboard:**

1. Import `uk_retail_sales_cleaned.csv` into SQL.
2. Run `UK_retail_sales.sql` to create the view.
3. Connect Power BI → SQL View → build dashboard.

---

### 🧾 Results Summary

* Online retail share rose from **<5 % to 27.9 %** by 2025.
* Retail continues steady upward growth despite recessions and COVID-19.
* Seasonality pattern remains stable — Q4 dominates.
* Forecast predicts continued **2–4 % annual growth**.
* Demonstrates **data cleaning**, **EDA**, **time-series forecasting**, **SQL integration**, and **Power BI reporting**.

---

### 👤 About Me

📍 London, UK

🎓 MSc Data Science — Birkbeck, University of London

🔗 [LinkedIn](https://www.linkedin.com/in/mohd-nafees-59863524b/)

📧 [nafees.mohd.datascientist25@gmail.com](mailto:nafees.mohd.datascientist25@gmail.com)

🗓️ November 2025

---



