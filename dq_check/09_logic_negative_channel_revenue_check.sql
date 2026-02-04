-- 09_logic_negative_channel_revenue_check.sql

-- CONTRACT:
-- Channel revenue can never be negative.
-- Any violation indicates invalid revenue conversion metrics.
-- This check is expected to return 0 rows.

-- REQUIRED INPUTS:
-- filter: revenue<0
-- table: mart.fct_channel_performance_daily
-- critical_column: revenue

SELECT
  COUNT(*) AS negative_revenue_rows
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
WHERE revenue<0;
