--1_stg_null_events_check.sql
--Purpose: To check the null count.
--Source: stg.events
--Notes: 0 null counts is best.

SELECT
  COUNTIF(event_date IS NULL) AS null_event_date,
  COUNTIF(event_ts IS NULL) AS null_event_timestamp,
  COUNTIF(event_name IS NULL) AS null_event_name,
  COUNTIF(user_key IS NULL) AS null_user_key,
  COUNTIF(session_key IS NULL) AS null_session_key
FROM `sunny-web-483615-q0.stg.events`
