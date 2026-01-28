--9_channel_negative_revenue_check.sql
--Purpose: To check the negative revenue rows count.
--Source: mart.fct_channel_performance_daily
--Note: This should always return 0.

SELECT
  COUNT(*) AS negative_revenue_rows
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
WHERE revenue<0;
