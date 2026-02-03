-- 3_metrics_negative_purchase_revenue_check.sql

-- CONTRACT:
-- Purchase revenue can never be negative.

--REQUIRE INPUTS:
-- Critical_column: purchase_revenue

SELECT
  COUNT(*) AS total_rows,
  COUNTIF(purchase_revenue<0) AS negative_purchase_revenue
FROM `sunny-web-483615-q0.stg.events`
