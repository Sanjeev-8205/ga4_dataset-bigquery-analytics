--highest_dropoff_funnel_step.sql
--Purpose: To aggregated the % of total dropoff pages contributed by each funnel step
--Grain: 1 row unique funnel step
--Source: mart.fct_funnel_steps_daily

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.highest_dropoff_funnel_step` AS
WITH drop_off AS (
  SELECT
    last_completed_step,
    funnel_status,
    COUNT(*) AS dropoff_count
  FROM `sunny-web-483615-q0.mart.fct_funnel_steps_daily`
  WHERE funnel_status NOT IN('Completed','Not Entered')
  GROUP BY last_completed_step,funnel_status
)
SELECT
  *,
  ROUND(SAFE_DIVIDE(dropoff_count,SUM(dropoff_count) OVER())*100,2) AS dropoff_perc_among_incomplete_funnels
FROM drop_off
GROUP BY last_completed_step,funnel_status,dropoff_count
ORDER BY dropoff_count
