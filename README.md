# End-to-End Fintech Fraud Detection System with Decision Intelligence & What-if Simulation

Built to simulate real-world payment risk systems (inspired by Mastercard Decision Intelligence)

Key Capability: Dynamic threshold optimisation to balance fraud detection vs customer experience


## Overview
This project simulates a real-world fintech fraud detection system inspired by platforms like Mastercard Decision Intelligence.

It is designed to detect fraudulent transactions while minimising false positives, enabling a balance between risk control and customer experience.

---

## Business Problem
In digital payments, financial institutions face a critical trade-off:

- Prevent fraud losses  
- Avoid blocking genuine customers  

Traditional rule-based systems often fail, leading to:
- High false positives (customer friction)
- Missed fraud (financial loss)

---

## Solution Summary
Built an end-to-end decision intelligence system that:

- Detects fraud using behavioural signals  
- Assigns transaction-level risk scores  
- Classifies decisions (APPROVE / REVIEW / DECLINE)  
- Enables dynamic threshold simulation for optimisation  

---

## System Architecture

Data Generation → MySQL → SQL Fraud Analysis → Python (Feature Engineering + Risk Scoring) → Power BI Dashboard → Decision Engine


---

##  Approach

### 1. Data Engineering (MySQL)
- Designed realistic transaction dataset (40K+ records)
- Simulated Indian payment behaviour patterns
- Included fraud signals (device change, night activity, spend spikes)

---

### 2. Fraud Pattern Analysis (MySQL)
- Amount spike detection  
- Device trust analysis  
- Merchant risk segmentation  
- Multi-signal fraud pattern discovery  

---

### 3. Feature Engineering (Python)
- Spend ratio (behavioural deviation)  
- Device trust & anomaly flags  
- Location anomaly detection  
- Time-based risk indicators  

---

### 4. Risk Scoring Model
- Built rule-based + ML-inspired scoring logic  
- Generated transaction-level risk scores  

---

### 5. Decision Engine
- APPROVE / REVIEW / DECLINE logic  
- Based on configurable risk thresholds  

---

##  Power BI Dashboards

###  Dashboard 1: Fraud Monitoring
- Fraud trends over time (day-level granularity)  
- Merchant category risk analysis  
- Location-based insights  

---

###  Dashboard 2: False Positive Analysis
- Root cause analysis of incorrect declines  
- Device, time, and behavioural drivers  
- Revenue impact due to blocked legitimate transactions  

---

###  Dashboard 3: Decision Intelligence
- Risk score distribution  
- Decision breakdown vs risk levels  
- What-if simulation for threshold optimisation  

---

##  Key Insights

- False positives were concentrated on **untrusted devices**, indicating over-reliance on device signals  
- **Location anomalies had minimal impact**, suggesting geo-signals were well-calibrated  
- **Moderate spend deviations triggered unnecessary declines**, highlighting scope for threshold tuning  

---

##  Business Impact

- Reduced false positives (simulated optimisation)  
- Improved fraud detection accuracy  
- Enabled data-driven decision-making for risk teams  
- Introduced dynamic trade-off analysis between fraud prevention and customer experience  

---

##  Key Highlight

Implemented a **dynamic threshold simulation layer** allowing stakeholders to:

- Adjust risk thresholds in real time  
- Visualize impact on fraud detection vs false positives  
- Optimize decision strategies interactively  

---

##  Tech Stack

- MySQL  
- Python (Pandas, NumPy)  
- Power BI  
- Advanced Excel  

---

##  Dashboard Preview

![Fraud Dashboard]
<img width="1755" height="1241" alt="DB_page-0001" src="https://github.com/user-attachments/assets/22c451ca-ed82-4280-af38-e86f463cfb5a" />


![False Positive Analysis]
<img width="1755" height="1241" alt="DB_page-0002" src="https://github.com/user-attachments/assets/8cac531b-8694-44e3-a46e-429e90bbdc76" />


![Decision Intelligence]
<img width="1755" height="1241" alt="DB_page-0003" src="https://github.com/user-attachments/assets/655a15dc-062d-4bb7-a16a-f922dd5a82ae" />

---

##  Author

**Chetan Sakate**  
Analyst | Fintech | Data & Decision Systems  

---

## Note
This project is a simulation built for analytical and learning purposes, inspired by real-world fintech systems.
