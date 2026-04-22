
WITH transaction_window AS (
    SELECT 
        Customer_id,
        transaction_date,
        transaction_time,
        transaction_amount,
        is_fraud,

        -- Combine date + time
        TIMESTAMP(transaction_date, transaction_time) AS txn_datetime,

        -- Previous transaction time
        LAG(TIMESTAMP(transaction_date, transaction_time)) 
            OVER (PARTITION BY customer_id ORDER BY transaction_date, transaction_time) 
        AS prev_txn_time

    FROM lmaq.`fraud_detection_data raw_data`
),

time_diff_calc AS (
    SELECT *,
        TIMESTAMPDIFF(
            MINUTE, 
            prev_txn_time, 
            txn_datetime
        ) AS minutes_between_txn
    FROM transaction_window
)

SELECT 
    customer_id,

    COUNT(*) AS TOTAL_TRANSACTIONS,

    SUM(is_fraud) AS FRAUD_COUNT,

    ROUND(AVG(transaction_amount), 2) AS AVG_TRANSACTION_AMOUNT,

    MAX(transaction_amount) AS MAX_TRANSACTION_AMOUNT,

    -- Fast transactions (velocity)
    SUM(
        CASE 
            WHEN minutes_between_txn <= 5 
            THEN 1 
            ELSE 0 
        END
    ) AS RAPID_TRANSACTIONS,

    -- Fraud rate
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS FRAUD_RATE_PCT,

    -- Risk classification
    CASE 
        WHEN SUM(is_fraud) >= 5 THEN 'CRITICAL'
        WHEN SUM(is_fraud) >= 3 THEN 'HIGH'
        WHEN SUM(is_fraud) >= 1 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS RISK_LEVEL

FROM time_diff_calc
GROUP BY customer_id
HAVING COUNT(*) >= 5
ORDER BY FRAUD_RATE_PCT DESC, RAPID_TRANSACTIONS DESC
LIMIT 20;