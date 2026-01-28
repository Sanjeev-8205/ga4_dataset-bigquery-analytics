--funnel_step_reach_trend.sql
--Purpose: To aggregate the daily percentage distribution of users on each funnel step.
--Grain: 1 row per event_date

CREATE VIEW `sunny-web-483615-q0.analytics.funnel_step_reach_trend` AS
SELECT
  event_date,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=0),COUNT(*)),4) AS zero_funnel_steps,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=1),COUNT(*)),4) AS one_funnel_steps,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=2),COUNT(*)),4) AS two_funnel_steps,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=3),COUNT(*)),4) AS three_funnel_steps,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=4),COUNT(*)),4) AS four_funnel_steps,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=5),COUNT(*)),4) AS five_funnel_steps,
  ROUND(SAFE_DIVIDE(COUNTIF(no_of_events_completed=6),COUNT(*)),4) AS six_funnel_steps,
FROM `sunny-web-483615-q0.mart.fct_funnel_steps_daily`
GROUP BY event_date;
