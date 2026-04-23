# 🚀 End-to-End Fintech Fraud Detection System with Decision Intelligence & What-if Simulation

💡 Built to simulate real-world payment risk systems inspired by Mastercard Decision Intelligence.

📊 **Key Capability:** Dynamic threshold optimization to balance fraud detection vs customer experience.

---

## 🎯 Business Problem

Digital payment systems face a critical challenge:

- Prevent fraudulent transactions (reduce financial loss)
- Avoid blocking genuine users (reduce customer friction)

Traditional rule-based systems often fail, resulting in:
- High false positives (poor customer experience)
- Missed fraud (revenue leakage)

---

## 💡 Solution Summary

This project builds a complete **decision intelligence system** that:

- Detects fraud using behavioral and transactional signals  
- Assigns transaction-level risk scores  
- Classifies decisions: **APPROVE / REVIEW / DECLINE**  
- Enables **dynamic threshold simulation** to optimize outcomes  

---

## 🏗️ System Architecture

<img width="1918" height="922" alt="image" src="https://github.com/user-attachments/assets/61f08bf7-c6f2-4869-bd04-8b1308c7b859" />

---

## 🧠 What Makes This Project Different

- Goes beyond fraud detection → includes **decision intelligence layer**  
- Focuses on **false positive optimization (customer experience)**  
- Implements **what-if simulation** for real-time threshold tuning  
- Built as an **end-to-end pipeline (data → model → decision → visualization)**  

---

## ⚙️ Approach

### 1️⃣ Data Engineering (MySQL)
- Created realistic dataset (~40,000 transactions)
- Simulated Indian payment behavior
- Embedded fraud patterns:
  - Night transactions  
  - Device switching  
  - Spend spikes  
  - Location anomalies  

---

### 2️⃣ Fraud Pattern Analysis (SQL)
- Amount spike detection  
- Device trust analysis  
- Merchant risk segmentation  
- Multi-signal fraud pattern discovery  

---

### 3️⃣ Feature Engineering (Python)
- Spend ratio (behavioral deviation)  
- Device trust & anomaly flags  
- Location anomaly detection  
- Time-based risk indicators  

---

### 4️⃣ Risk Scoring Model
- Built rule-based + ML-inspired scoring logic  
- Generated transaction-level **risk_score**  

---

### 5️⃣ Decision Engine
- Transactions classified into:
  - APPROVE  
  - REVIEW  
  - DECLINE  
- Based on configurable risk thresholds  

---

## 📊 Power BI Dashboards

### 🔹 Dashboard 1: Fraud Monitoring
Tracks fraud trends, merchant risk, and geographic distribution.

<img width="1755" height="1241" alt="DB_page-0001" src="https://github.com/user-attachments/assets/ef8897b6-022e-482b-aa07-26913c0a1ee8" />


---

### 🔹 Dashboard 2: False Positive Analysis
Identifies root causes of incorrect declines and customer friction drivers.

<img width="1755" height="1241" alt="DB_page-0002" src="https://github.com/user-attachments/assets/be10ce96-b2c5-45aa-8ac8-353deae53600" />

---

### 🔹 Dashboard 3: Decision Intelligence
Enables threshold-based simulation to balance fraud detection vs false positives.

<img width="1755" height="1241" alt="DB_page-0003" src="https://github.com/user-attachments/assets/b66aebab-4b9f-4d13-a48e-bfdc7083df9b" />

---

## 🔥 Key Insights

- False positives were concentrated on **untrusted devices**, indicating over-sensitive device rules  
- **Location anomalies had minimal impact**, suggesting geo-signals were well-calibrated  
- **Moderate spend spikes triggered unnecessary declines**, highlighting scope for threshold tuning  

---

## 📈 Business Impact (Simulated)

- Processed 40,000+ transactions with a fraud rate of ~32%  
- Achieved ~79% precision, ensuring most flagged transactions were genuinely fraudulent  
- Detected ~6,100+ fraudulent transactions using risk-based scoring  
- Identified ~1,600 false positives, highlighting opportunities for customer experience optimization  
- Prevented ~₹3.5 Cr worth of fraudulent transactions (simulated)  
- Identified ~₹43 L of genuine transactions incorrectly flagged, enabling targeted false positive reduction strategies  
- Enabled data-driven threshold optimization to balance fraud detection vs customer friction  

---

## 🌍 Real-World Relevance

This system mirrors real-world fraud platforms used by payment networks such as Mastercard and Visa, where decision engines continuously optimize fraud prevention while maintaining seamless user experience.

---

## 📊 Dataset

- 40,000+ simulated transactions  
- Reflects Indian payment behavior  
- Includes engineered fraud signals and behavioral patterns  

---

## ▶️ How to Run

1. Load dataset from `/data`  
2. Execute SQL scripts from `/sql`  
3. Run Python notebooks for feature engineering and scoring  
4. Open Power BI dashboard to explore insights and simulation  

---

## ⚙️ Tech Stack

- MySQL  
- Python (Pandas, NumPy)  
- Power BI  
- Advanced Excel  

---

## 🧠 Key Highlight

Implemented a **dynamic threshold simulation layer** allowing stakeholders to:

- Adjust risk thresholds in real time  
- Observe impact on fraud detection and false positives  
- Optimize decision-making interactively  

---

## 👤 Author

**Chetan Sakate**  
Analyst | Fintech | Data & Decision Systems  

---

## 📌 Note

This project is a simulation created for analytical and learning purposes, inspired by real-world fintech systems.
