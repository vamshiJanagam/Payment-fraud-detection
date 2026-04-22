-- TIME-BASED FRAUD ANALYSIS (FULL FIXED)
-- =========================================


-- =========================================
-- 1. FRAUD RATE BY HOUR
-- =========================================

SELECT 
    HOUR(transaction_time) AS TRANSACTION_HOUR,

    COUNT(*) AS TOTAL_TRANSACTIONS,
    SUM(is_fraud) AS FRAUD_COUNT,

    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS FRAUD_RATE_PCT,

    ROUND(AVG(transaction_amount), 2) AS AVG_TRANSACTION_AMOUNT

FROM lmaq.`fraud_detection_data raw_data`
GROUP BY HOUR(transaction_time)
ORDER BY FRAUD_RATE_PCT DESC;



-- =========================================
-- 2. TIME CATEGORY (NIGHT / WEEKEND / BUSINESS)
-- =========================================

SELECT 
    CASE 
        WHEN HOUR(transaction_time) BETWEEN 23 AND 23 
             OR HOUR(transaction_time) BETWEEN 0 AND 4 
        THEN 'NIGHT (11PM-4AM)'

        WHEN DAYOFWEEK(transaction_date) IN (1,7) 
        THEN 'WEEKEND'

        ELSE 'BUSINESS HOURS'
    END AS TIME_CATEGORY,

    COUNT(*) AS TOTAL_TRANSACTIONS,

    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS FRAUD_RATE_PCT,

    ROUND(AVG(transaction_amount), 2) AS AVG_TRANSACTION_AMOUNT

FROM lmaq.`fraud_detection_data raw_data`
GROUP BY TIME_CATEGORY
ORDER BY FRAUD_RATE_PCT DESC;



-- =========================================
-- 3. MONTHLY FRAUD TREND (WITH LAG)
-- =========================================

WITH monthly_data AS (
    SELECT 
        DATE_FORMAT(transaction_date, '%Y-%m') AS YR_MONTH,

        COUNT(*) AS TOTAL_TRANSACTIONS,
        SUM(is_fraud) AS FRAUD_COUNT,

        ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS FRAUD_RATE_PCT

    FROM lmaq.`fraud_detection_data raw_data`
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
)

SELECT 
    YR_MONTH,
    TOTAL_TRANSACTIONS,
    FRAUD_COUNT,
    FRAUD_RATE_PCT,

    LAG(FRAUD_RATE_PCT) OVER (ORDER BY YR_MONTH) AS PREV_MONTH_RATE,

    ROUND(
        FRAUD_RATE_PCT - 
        LAG(FRAUD_RATE_PCT) OVER (ORDER BY YR_MONTH),
    2) AS MOM_CHANGE_PCT

FROM monthly_data
ORDER BY YR_MONTH;