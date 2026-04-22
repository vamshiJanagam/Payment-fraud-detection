-- =========================================
-- FRAUD FINANCIAL IMPACT ANALYSIS
-- =========================================

SELECT 
    City,
    Merchant_category,

    COUNT(*) AS TOTAL_TRANSACTIONS,

    ROUND(SUM(transaction_amount), 0) AS TOTAL_VOLUME,

    -- Fraud transactions count
    SUM(is_fraud) AS FRAUD_COUNT,

    -- Fraud loss (money lost)
    ROUND(
        SUM(
            CASE 
                WHEN is_fraud = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ), 0
    ) AS FRAUD_LOSS,

    -- Chargeback loss
    ROUND(
        SUM(
            CASE 
                WHEN chargeback_raised = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ), 0
    ) AS CHARGEBACK_LOSS,

    -- Total financial risk
    ROUND(
        SUM(
            CASE 
                WHEN is_fraud = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ) +
        SUM(
            CASE 
                WHEN chargeback_raised = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ), 0
    ) AS TOTAL_RISK_AMOUNT,

    -- Fraud rate %
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS FRAUD_RATE_PCT

FROM lmaq.`fraud_detection_data raw_data`
GROUP BY city, merchant_category
ORDER BY TOTAL_RISK_AMOUNT DESC;