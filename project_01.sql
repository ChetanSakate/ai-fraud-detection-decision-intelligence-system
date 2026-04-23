CREATE DATABASE fraud_detection;
USE fraud_detection;

-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    city VARCHAR(50),
    avg_spend INT,
    risk_segment VARCHAR(20)
);

-- Devices
CREATE TABLE devices (
    device_id INT PRIMARY KEY,
    device_type VARCHAR(20),
    is_trusted TINYINT
);

-- Transactions
CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    merchant_category VARCHAR(50),
    txn_time DATETIME,
    location VARCHAR(50),
    device_id INT
);

-- Fraud Labels
CREATE TABLE fraud_labels (
    txn_id INT,
    is_fraud TINYINT
);

-- DATA VALIDATION CHECK
SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) FROM fraud_labels;


SELECT 
    SUM(is_fraud)/COUNT(*) AS fraud_rate
FROM fraud_labels;

-- “The dataset had a higher fraud ratio (~32%) due to controlled simulation, which helped in identifying strong fraud signals. In real-world deployment, this would be significantly lower, requiring rebalancing techniques.” 


-- PHASE 3: SQL ANALYSIS — FRAUD PATTERN DISCOVERY

-- 1. FRAUD DISTRIBUTION OVER TIME (CRITICAL)
-- Question:  Does fraud spike at certain hours?

SELECT 
    HOUR(t.txn_time) AS txn_hour,
    COUNT(*) AS total_txns,
    SUM(f.is_fraud) AS fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) AS fraud_rate
FROM transactions t
JOIN fraud_labels f ON t.txn_id = f.txn_id
GROUP BY txn_hour
ORDER BY fraud_rate DESC;
--  fraud between 1 AM – 5 AM
-- “Fraudsters exploit low monitoring hours and reduced user vigilance during late-night periods.”


-- 2. LOCATION ANOMALY ANALYSIS
-- Question: Are cross-city transactions risky?

SELECT 
    c.city AS home_city,
    t.location AS txn_city,
    COUNT(*) AS total_txns,
    SUM(f.is_fraud) AS fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) AS fraud_rate
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN fraud_labels f ON t.txn_id = f.txn_id
WHERE c.city != t.location
GROUP BY c.city, t.location
ORDER BY fraud_rate DESC;

-- “Cross-location transactions show significantly higher fraud probability, indicating potential account compromise.”

-- 3. AMOUNT SPIKE ANALYSIS
-- Question: Are high-value transactions more fraudulent?
-- ADV
  SELECT 
    t.txn_id,
    t.customer_id,
    t.amount,
    c.avg_spend,
    ROUND(t.amount / c.avg_spend, 2) AS spend_ratio,
    f.is_fraud
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN fraud_labels f ON t.txn_id = f.txn_id
WHERE t.amount > c.avg_spend * 2
ORDER BY spend_ratio DESC;

SELECT 
    CASE 
        WHEN t.amount < c.avg_spend THEN 'Below Avg'
        WHEN t.amount BETWEEN c.avg_spend AND 2*c.avg_spend THEN 'Normal'
        WHEN t.amount BETWEEN 2*c.avg_spend AND 3*c.avg_spend THEN 'High Spike'
        ELSE 'Extreme Spike'
    END AS spend_behavior,
    COUNT(*) total_txns,
    SUM(f.is_fraud) fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) fraud_rate
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN fraud_labels f ON t.txn_id = f.txn_id
GROUP BY spend_behavior
ORDER BY fraud_rate DESC;

-- “Fraud is not driven by absolute amount but by deviation from a customer’s historical spending behavior.”

   
   -- 4. DEVICE TRUST ANALYSIS 
   -- Combine device + behavior + outcome
   SELECT 
    d.device_type,
    d.is_trusted,
    COUNT(*) total_txns,
    SUM(f.is_fraud) fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) fraud_rate,
    ROUND(AVG(t.amount),0) avg_txn_value
FROM transactions t
JOIN devices d ON t.device_id = d.device_id
JOIN fraud_labels f ON t.txn_id = f.txn_id
GROUP BY d.device_type, d.is_trusted
ORDER BY fraud_rate DESC;

SELECT 
    d.is_trusted,
    CASE 
        WHEN HOUR(t.txn_time) BETWEEN 1 AND 5 THEN 'Night'
        ELSE 'Day'
    END AS time_band,
    COUNT(*) total_txns,
    SUM(f.is_fraud) fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) fraud_rate
FROM transactions t
JOIN devices d ON t.device_id = d.device_id
JOIN fraud_labels f ON t.txn_id = f.txn_id
GROUP BY d.is_trusted, time_band
ORDER BY fraud_rate DESC;

-- “Untrusted devices alone are not sufficient signals, but when combined with temporal anomalies (e.g., late-night usage), fraud probability increases significantly.”



-- 5. MERCHANT CATEGORY RISK
-- Risk + Volume Tradeoff : Which category is dangerous at scale

SELECT 
    t.merchant_category,
    COUNT(*) total_txns,
    SUM(f.is_fraud) fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) fraud_rate,
    ROUND(AVG(t.amount),0) avg_txn_value
FROM transactions t
JOIN fraud_labels f ON t.txn_id = f.txn_id
GROUP BY t.merchant_category
HAVING total_txns > 500
ORDER BY fraud_rate DESC;

-- Risk Prioritization View

SELECT 
    t.merchant_category,
    COUNT(*) total_txns,
    SUM(f.is_fraud) fraud_txns,
    (SUM(f.is_fraud) * AVG(t.amount)) AS estimated_loss
FROM transactions t
JOIN fraud_labels f ON t.txn_id = f.txn_id
GROUP BY t.merchant_category
ORDER BY estimated_loss DESC;
   
   -- “Risk prioritization should be driven by financial impact, not just fraud rate — some categories may have lower fraud rates but higher total loss exposure.”
   
   -- 6. MULTI-SIGNAL FRAUD PATTERN : Decision Intelligence system
     SELECT 
    CASE 
        WHEN d.is_trusted = 0 THEN 'Untrusted Device'
        ELSE 'Trusted Device'
    END AS device_risk,
    
    CASE 
        WHEN t.amount > c.avg_spend * 2 THEN 'High Spend Spike'
        ELSE 'Normal Spend'
    END AS spend_risk,
    
    CASE 
        WHEN c.city != t.location THEN 'Location Anomaly'
        ELSE 'Normal Location'
    END AS location_risk,

    CASE 
        WHEN HOUR(t.txn_time) BETWEEN 1 AND 5 THEN 'Night Risk'
        ELSE 'Normal Time'
    END AS time_risk,

    COUNT(*) total_txns,
    SUM(f.is_fraud) fraud_txns,
    ROUND(SUM(f.is_fraud)/COUNT(*), 2) fraud_rate

FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN devices d ON t.device_id = d.device_id
JOIN fraud_labels f ON t.txn_id = f.txn_id

GROUP BY device_risk, spend_risk, location_risk, time_risk
HAVING total_txns > 100
ORDER BY fraud_rate DESC;

-- “Fraud likelihood spikes when multiple risk signals co-occur — Early Morning + untrusted device + location anomaly.”





