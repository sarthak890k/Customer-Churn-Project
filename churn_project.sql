
CREATE TABLE customers (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(30),
    MonthlyCharges NUMERIC,
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

set sql_safe_updates = 1;

-- Set blank/whitespace values to NULL
UPDATE customers SET TotalCharges = NULL WHERE TRIM(TotalCharges) = '';

-- Now safely convert the column type
ALTER TABLE customers MODIFY TotalCharges DECIMAL(10,2);

-- Q1: What is the overall customer churn rate across the entire customer base?

select count(*),
sum(case when churn = 'yes' then 1 else 0 end) as churned_customer,
round(100*sum(case when churn = 'yes' then 1 else 0 end)/count(*),2)as churn_rate
from customers;

-- Q2: Does contract type influence churn — are month-to-month customers more likely to leave than those on longer contracts?

select contract,count(*),
round(100*(sum(case when churn='yes' then 1 else 0 end)/count(*)),2) as churn_rate,
sum(case when churn='yes' then 1 else 0 end) as churned_customers
from customers
group by contract
order by churn_rate;

-- Q3: How does tenure (how long a customer has stayed) affect their likelihood of churning?

SELECT 
  CASE 
    WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
    WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
    WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
    WHEN tenure BETWEEN 49 AND 60 THEN '49-60 months'
    ELSE '60+ months'
  END AS tenure_bucket,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY tenure_bucket
ORDER BY MIN(tenure);

-- Q4: Are customers paying higher monthly charges more likely to churn than those paying less?


SELECT 
  CASE 
    WHEN MonthlyCharges < 35 THEN 'Low (<$35)'
    WHEN MonthlyCharges BETWEEN 35 AND 70 THEN 'Medium ($35-70)'
    ELSE 'High (>$70)'
  END AS charge_band,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY charge_band
ORDER BY churn_rate DESC;

-- Q5: Does the combination of internet service type and tech support availability affect churn — are fiber optic customers without tech support at higher risk?


SELECT 
  InternetService,
  TechSupport,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY InternetService, TechSupport
ORDER BY churn_rate DESC;

-- Q6: Do customers without add-on protection services (online security, device protection) churn more than those who have them?


SELECT 
  OnlineSecurity,
  DeviceProtection,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY OnlineSecurity, DeviceProtection
ORDER BY churn_rate DESC;


-- Q7: Is there a relationship between payment method and churn — do customers on manual payment methods (like electronic check) churn more than those on automatic payments?



SELECT 
  PaymentMethod,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;


-- Q8: Are senior citizens more likely to churn than non-senior customers?

SELECT 
  CASE WHEN SeniorCitizen = 1 THEN 'Senior' ELSE 'Non-Senior' END AS customer_type,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY customer_type;

-- Q9: Does using paperless billing correlate with a higher or lower churn rate?

SELECT 
  PaperlessBilling,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY PaperlessBilling;