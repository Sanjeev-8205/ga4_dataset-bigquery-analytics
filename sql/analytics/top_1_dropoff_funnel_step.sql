--top_1_dropoff_funnel_step.sql
--Purpose: To find the #1 last completed funnel step before the user exits the funnel.
--Source: mart.fct_dropoff_pages_daily

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.top_1_dropoff_funnel_step` AS
WITH top_dropoff_page AS(
  SELECT
    last_completed_step,
    dropoff_page,
    CAST(SUM(no_of_users) AS INT64) AS no_of_users
  FROM `sunny-web-483615-q0.mart.fct_dropoff_pages_daily`
  GROUP BY last_completed_step,dropoff_page
  ORDER BY no_of_users DESC LIMIT 1
)
SELECT
  CASE
    WHEN last_completed_step='view_item' THEN 'View Item'
  END AS lcs
FROM top_dropoff_page
