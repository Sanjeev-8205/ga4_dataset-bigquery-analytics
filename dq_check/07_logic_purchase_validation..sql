-- 07_logic_purchase_validation.sql

-- CONTRACT:
-- No.of purchases can never be less than no.of purchasers.
-- Any violation to this rule indicates invalid conversion metrics.

-- REQUIRED INPUTS:
-- table: mart.fct_channel_performance_daily
-- critical_column: purchasers, purchases

SELECT
  SUM(purchasers) AS no_of_purchasers,
  SUM(purchases) AS no_of_purchases,
  CASE
    WHEN SAFE_DIVIDE(SUM(purchases),SUM(purchasers))>=1 THEN 'Valid'
    ELSE "Invalid"
  END AS purchase_validation
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
