-- 05_logic_completed_funnel_terminal_check.sql

-- CONTRACT:
-- If a funnel is marked as Completed, then the last completed step must be the terminal funnel step.
-- Any violation indicates inconsistent funnel state and invalid conversion metrics.

-- REQUIRED INPUTS:
-- table: mart.fct_funnel_steps_daily
-- condition:
--   funnel_status = 'Completed'
-- terminal_step='purchase'
-- critical_column: funnel_status, last_completed_step

SELECT
  COUNT(*) AS invalid_funnel_rows
FROM `sunny-web-483615-q0.mart.fct_funnel_steps_daily`
WHERE funnel_status='Completed' AND last_completed_step!='purchase';
