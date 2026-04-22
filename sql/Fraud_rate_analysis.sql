
SELECT 
    Merchant_category,

    COUNT(*) AS Total_transactions,
    SUM(is_fraud) AS Fraud_count,

    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS Fraud_rate_pct,

    ROUND(
        SUM(
            CASE 
                WHEN is_fraud = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ), 0
    ) AS Fraud_amount

FROM lmaq.`fraud_detection_data raw_data`
GROUP BY merchant_category
ORDER BY fraud_rate_pct DESC;