--3_stg_event_negative_purchase_revenue_check.sql
--Purpose: To check the null and negatice purchase revenue.
--Source: stg.events
--Note: Zero null or negative counts is best.

SELECT
  COUNT(*),
  COUNTIF(purchase_revenue IS NULL) AS null_purchase_revenue,
  COUNTIF(purchase_revenue<0) AS negative_purchase_revenue
FROM `sunny-web-483615-q0.stg.events`
