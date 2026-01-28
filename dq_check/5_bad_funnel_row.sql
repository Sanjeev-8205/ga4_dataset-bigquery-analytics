--5_bad_funnel_rows.sql
--Purpose: To check for funnel rows funnel stats is completed but last funnel step is not purchase..
--Source: mart.fct_funnel_steps_daily
--Note: This should return 0.

SELECT
  COUNT(*) AS invalid_funnel_rows
FROM `sunny-web-483615-q0.mart.fct_funnel_steps_daily`
WHERE funnel_status='Completed' AND last_completed_step!='purchase';
