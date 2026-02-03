--01_null_struct_critical_column_check.sql

-- CONTRACT:
-- Critical identifier columns should never be null.

--REQUIRED INPUTS:
-- table: stg.events
-- Critical columns: event_date, event_ts, event_name, user_key, session_key

SELECT
  COUNT(*) AS total_rows,

  COUNTIF(event_date IS NULL) AS null_event_date,
  COUNTIF(event_ts IS NULL) AS null_event_timestamp,
  COUNTIF(event_name IS NULL) AS null_event_name,
  COUNTIF(user_key IS NULL) AS null_user_key,
  COUNTIF(session_key IS NULL) AS null_session_key
FROM `sunny-web-483615-q0.stg.events`
