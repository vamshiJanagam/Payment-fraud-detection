# 🔐 Fraud Detection & Risk Analysis

## 📌 Project Overview

This project focuses on analyzing transaction data to identify **fraud patterns**, **high-risk customers**, and **financial impact due to fraudulent activities**. Using SQL, the analysis uncovers behavioral, temporal, and financial indicators of fraud.

---

## 🎯 Objectives

* Measure fraud rates across different dimensions
* Identify high-risk customers and suspicious behavior
* Analyze fraud trends over time
* Evaluate financial impact of fraud and chargebacks
* Detect high-risk transaction channels (bank & device)

---

## 🛠 Tools Used

* **SQL (MySQL)** – Data analysis and querying
* **Excel / Power Query** – Data preprocessing
* *(Optional)* Power BI – Visualization

---

## 📊 Dataset

* Transaction dataset (~50,000 records)
* Includes:

  * Transaction details (date, time, amount)
  * Customer data (customer_id)
  * Fraud indicators (is_fraud, chargeback_raised)
  * Risk signals (ip_risk_score)
  * Channel data (bank, device_type)
  * Location data (city, zone, merchant_category)

---

## 🔍 Key Analysis Performed

### 1️⃣ Fraud Rate Analysis

* Calculated overall fraud rate
* Segmented by **city, zone, and merchant category**

---

### 2️⃣ Customer Risk Analysis

* Identified high-risk customers using:

  * Fraud rate
  * Transaction frequency
  * Chargebacks
  * IP risk score
* Ranked customers based on risk level

---

### 3️⃣ Time-Based Fraud Analysis

* Analyzed fraud patterns by:

  * Hour of transaction
  * Night vs business hours
  * Monthly trends
* Used **window functions (LAG)** for trend analysis

---

### 4️⃣ Financial Impact Analysis

* Calculated:

  * Fraud loss (fraudulent transaction value)
  * Chargeback loss
  * Total financial risk

---

### 5️⃣ Fraud Pattern Detection

* Detected suspicious behavior using:

  * Rapid transactions (velocity analysis)
  * Transaction time gaps
  * High-frequency fraud activity

---

### 6️⃣ Bank & Device Analysis

* Compared fraud rates across:

  * Different banks
  * Device types (mobile, web, POS)
* Identified high-risk transaction channels

---

## 💡 Key Insights

* Fraud activity is higher during **late-night hours**
* Certain **merchant categories and devices** show higher fraud rates
* High-frequency transactions within short intervals indicate suspicious behavior
* Fraud loss is concentrated in **high-value transactions**
* Chargebacks significantly increase overall financial impact
* Python was used for data preprocessing, advanced analysis, and automation, while Power BI was used to build interactive dashboards for visualizing fraud trends and insights

---

## 📁 Project Structure (with Python & Power BI)

```text
fraud-detection-analysis/
│
├── data/
│   └── raw_data.csv
│
├── sql/
│   ├── fraud_rate_analysis.sql
│   ├── customer_risk_analysis.sql
│   ├── time_based_fraud_analysis.sql
│   ├── fraud_financial_impact.sql
│   ├── fraud_pattern_detection.sql
│   └── fraud_bank_device_analysis.sql
│
├── python/
│   ├── data_cleaning.py
│   ├── fraud_analysis.py
│   ├── customer_risk_model.py
│   └── visualization.py
│
├── powerbi/
│   └── fraud_dashboard.pbix
│
├── excel/
│   └── analysis.xlsx
│
└── README.md
```

---

## 🚀 How to Run

1. Import dataset into MySQL
2. Execute SQL scripts from `/sql` folder
3. Run queries to generate insights

---

## 💼 Business Value

This analysis helps:

* Detect fraudulent transactions early
* Reduce financial losses
* Improve fraud monitoring systems
* Strengthen risk management strategies

---

## 👤 Author

Vamshi
Aspiring Data Analyst | SQL | Excel | Power BI
