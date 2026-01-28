--6_invalid_no_of_events_check.sql
--Purpose: To check if any row in no_of_events column is out of range i.e., >6 or <0.
--Source: mart.fct_funnel_steps_daily
--Note: This should return 0.

SELECT
  COUNTIF(no_of_events_completed>6) excess_no_of_events,
  COUNTIF(no_of_events_completed<0) invalid_no_of_events
FROM `sunny-web-483615-q0.mart.fct_funnel_steps_daily`
