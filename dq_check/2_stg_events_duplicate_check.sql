--2_stg_events_duplicate_check.sql
--Purpose: To check the duplicate count of the grain.
--Source: stg.events
--Note: 0 duplicate counts is best.

SELECT
  COUNT(*),
  COUNT(DISTINCT CONCAT(session_key,'-',event_ts,'-',event_name)),
  COUNT(*)-COUNT(DISTINCT CONCAT(session_key,'-',event_ts,'-',event_name)) AS duplicates
FROM `sunny-web-483615-q0.stg.events` 
