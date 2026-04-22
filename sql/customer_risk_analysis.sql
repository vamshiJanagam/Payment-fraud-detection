WITH customer_stats AS (
    SELECT 
        Customer_id,

        COUNT(*) AS Total_transactions,

        SUM(is_fraud) AS Fraud_transactions,

        ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS Fraud_rate_pct,

        ROUND(AVG(transaction_amount), 2) AS Avg_transaction_amount,

        MAX(transaction_amount) AS Max_transaction_amount,

        SUM(chargeback_raised) AS Total_chargebacks,

        ROUND(AVG(ip_risk_score), 2) AS Avg_ip_risk_score

    FROM lmaq.`fraud_detection_data raw_data`
    GROUP BY customer_id
    HAVING COUNT(*) >= 5   -- filter small sample customers
)

SELECT 
    Customer_id,
    Total_transactions,
    Fraud_transactions,
    Fraud_rate_pct,
    Avg_transaction_amount,
    Max_transaction_amount,
    Total_chargebacks,
    Avg_ip_risk_score,

    -- Ranking worst customers
    RANK() OVER (ORDER BY Fraud_rate_pct DESC) AS Risk_rank,

    -- Risk classification
    CASE 
        WHEN fraud_rate_pct > 50 THEN 'Critical'
        WHEN fraud_rate_pct > 25 THEN 'High'
        WHEN fraud_rate_pct > 10 THEN 'Medium'
        ELSE 'Low'
    END AS Risk_tier

FROM customer_stats
ORDER BY Fraud_rate_pct DESC
LIMIT 20;