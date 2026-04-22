-- =========================================
-- FRAUD BY BANK + DEVICE
-- =========================================

SELECT 
    bank AS BANK,
    device_type AS DEVICE_TYPE,

    COUNT(*) AS TOTAL_TRANSACTIONS,
    SUM(is_fraud) AS FRAUD_COUNT,

    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS FRAUD_RATE_PCT,

    ROUND(
        SUM(
            CASE 
                WHEN is_fraud = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ), 2
    ) AS FRAUD_LOSS,

    ROUND(
        SUM(
            CASE 
                WHEN chargeback_raised = 1 
                THEN transaction_amount 
                ELSE 0 
            END
        ), 2
    ) AS CHARGEBACK_LOSS

FROM lmaq.`fraud_detection_data raw_data`
GROUP BY bank, device_type
ORDER BY FRAUD_RATE_PCT DESC;