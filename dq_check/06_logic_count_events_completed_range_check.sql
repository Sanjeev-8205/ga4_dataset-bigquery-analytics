-- 06_logic_count_events_completed_range_check.sql

-- CONTRACT:
-- No out of range events completed count is allowed.
-- Any violation indicates invalid conversion of metrics.

-- REQUIRED INPUTS:
-- table: mart.fct_funnel_steps_daily
-- critical_columns: no_of_events_completed

SELECT
  COUNTIF(no_of_events_completed>6) excess_no_of_events,
  COUNTIF(no_of_events_completed<0) invalid_no_of_events
FROM `sunny-web-483615-q0.mart.fct_funnel_steps_daily`
