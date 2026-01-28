--8_invalid_conversion_rate_check.sql
--Purpose: To verify that the conversion rate is not out of range.
--Source: mart.fct_channel_performance_daily
--Note: This should return 0.

SELECT
  COUNTIF(conversion_rate<0 AND conversion_rate>1) AS invalid_rows
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
