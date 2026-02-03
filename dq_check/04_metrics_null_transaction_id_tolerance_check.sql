-- 04_metrics_null_transaction_id_tolerance_check.sql

-- CONTRACT:
-- For purchase events, transaction_id must be present.
-- A small percentage of NULL transaction_id is tolerated.
-- (e.g. purchases from unknown sources), but must remain below 5%.
-- Exceeding this will make the revenue metrics invalid.

-- REQUIRED INPUTS:
-- filters: event_name='purchase'
-- critical_column: transaction_id
-- tolerance_threshold: 5%

SELECT
  COUNT(*) AS no_of_purchases,
  COUNTIF(transaction_id IS NULL) AS null_transaction_id,
  SAFE_DIVIDE(COUNTIF(transaction_id IS NULL), COUNT(*)) AS null_transaction_perc
FROM `sunny-web-483615-q0.stg.events`
WHERE event_name='purchase'
