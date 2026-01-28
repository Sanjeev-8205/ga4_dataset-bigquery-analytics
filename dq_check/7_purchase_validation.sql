--7_purchase_validation.sql
--Purpose: To verify that the no. of purchases is more than no. of purchasers.
--Source: mart.fct_channel_performance_daily
--Note: This should return Valid.

SELECT
  SUM(purchasers) AS no_of_purchasers,
  SUM(purchases) AS no_of_purchases,
  CASE
    WHEN SAFE_DIVIDE(SUM(purchases),SUM(purchasers))>=1 THEN 'Valid'
    ELSE "Invalid"
  END AS purchase_validation
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
