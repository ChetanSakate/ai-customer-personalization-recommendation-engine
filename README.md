# 🤖 AI-Powered Customer Personalization & Recommendation Engine

🚀 Simulated a +10% increase in conversion rate and +5% uplift in AOV using customer segmentation and behavioral personalization.

Built using Python, MySQL, and Tableau to replicate real-world fintech recommendation systems.


## 📌 Overview

This project builds an end-to-end customer personalization system designed to improve conversion rates and revenue through intelligent recommendations.

It combines **customer segmentation, behavioral signals, and explainable scoring logic** to deliver relevant product suggestions—similar to systems used in modern fintech and e-commerce platforms.

---

## 🎯 Business Problem

Many digital platforms suffer from:

* Generic offers
* Low conversion rates
* Poor customer engagement

This project addresses these issues by enabling **data-driven personalization**.

---

## 💡 Solution

A hybrid recommendation engine that integrates:

* **Customer segmentation (K-Means)**
* **Behavioral intent (views, purchases)**
* **Business-driven scoring logic**
* **Explainable recommendations**

---

## 🧠 System Architecture

MySQL (Raw Data)
   ↓
Python (Feature Engineering + KMeans Clustering)
   ↓
Recommendation Engine (Scoring + Personalization)
   ↓
Tableau Dashboard (Business Insights)

<img width="1859" height="900" alt="image" src="https://github.com/user-attachments/assets/ad39082f-f571-4029-ab2e-ca9e63932e89" />

---

## 🧩 Data Sources

* Customer Transactions (purchase history, recency)
* Browsing Behavior (product views)
* Product Catalog (price, category, rating)
* Derived Customer Features (RFM + behavioral metrics)

---

## ⚙️ Tech Stack

* **Python** (Pandas, NumPy, Scikit-learn)
* **MySQL** (data storage & extraction)
* **Tableau** (dashboard & business insights)

---

## 🧠 Methodology

### 1. Data Engineering

* Extracted and joined data from MySQL
* Built customer-level features:

  * Recency
  * Frequency
  * Total Spend
  * Conversion Rate
  * Discount Sensitivity

---

### 2. Customer Segmentation

* Applied **K-Means clustering**
* Identified key segments:

<img width="610" height="274" alt="image" src="https://github.com/user-attachments/assets/a68ab981-1f55-45a3-8dbf-492d6ad8de27" />

---

### 3. Recommendation Engine

Built a scoring-based recommendation system using:

* Purchase frequency
* Browsing intent (views)
* Product rating & discount
* Segment-specific tuning
* Recency-based boost
* 
##  Sample Recommendation Output

<img width="1117" height="314" alt="image" src="https://github.com/user-attachments/assets/56ce681a-bee7-4be1-b2b8-b3e2eaab14a4" />

---


#### Key Features:

* Excludes already purchased products
* Adds **intent boost**
* Applies **segment-aware scoring**
* Includes **explainability layer** ("reason" column)
* Maintains **category diversity**

---

### 4. Business Impact Simulation

To estimate real-world value:

* Assumed:

  * +10% conversion uplift
  * +5% AOV increase

* Calculated:

  * Baseline vs projected revenue
  * Baseline revenue 34.28 Cr & Projected revenue 41.91 Cr, Potential Impact +15.50%
  * Segment-wise impact contribution

---

## 📊 Dashboard Preview

### Dashboard 1: Customer Segmentation & Behavior
<img width="1755" height="1241" alt="Dashboard_01_page-0001" src="https://github.com/user-attachments/assets/56bfaba3-12fc-4d85-b6cc-188f6b7181c2" />

* Segment distribution
* Revenue by segment
* Conversion analysis
* Recency vs spend insights

### Dashboard 2: Recommendation Engine Insights
<img width="1755" height="1240" alt="DB_02_page-0001" src="https://github.com/user-attachments/assets/299bd296-9e63-424b-a951-c76bd1de9131" />

* Category distribution of recommendations
* Price band analysis
* Explainability (reason distribution)
* Segment-wise recommendation patterns

---

## 📈 Key Insights

* High-value customers drive disproportionate revenue
* Deal-seeking users browse more but convert less
* Recommendations are skewed toward affordable price bands
* Premium products are selectively targeted

---

## 💰 Business Impact

📈 Conversion Rate: +10%

🛒 Average Order Value: +5%

💵 Revenue Growth: ₹34.28 Cr → ₹41.91 Cr

🚀 Total Uplift: +15.5%

👉 Insight: Personalisation significantly improves both purchase likelihood and spend per user

---

## 🤔 Why This Matters

In fintech and digital commerce:

Personalization = Revenue engine
Better targeting = Higher retention
Behavioral insights = Smarter decision-making

---

## 🔥 Highlights

* End-to-end pipeline (data → model → dashboard)
* Business-first thinking (not just ML)
* Explainable AI approach
* Scalable and modular design

---

## 🛠️ How to Run

1. Clone the repository
2. Install dependencies:

   ```
   pip install -r requirements.txt
   ```
3. Run notebooks in sequence:

   * Data extraction
   * Feature engineering
   * Clustering
   * Recommendation engine

---

## 📌 Future Improvements

* Real-time recommendation API
* A/B testing framework
* Deep learning-based recommendation models
* User session tracking for better intent modeling

---

## 👨‍💻 Author

Chetan Sakate

---

## 💬 Note

This project is designed to simulate a real-world personalization system and demonstrate both **technical implementation and business impact thinking**.
