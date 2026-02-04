--02_struct_duplicate_row_check.sql

--CONTRACT:
--Rows should never be duplicate.

--REQUIRED INPUTS:
--Table: stg.events
--Critical_columns: session_key, event_ts, event_name

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT CONCAT(session_key,'-',event_ts,'-',event_name)) AS distinct_no_of_rows,
  COUNT(*)-COUNT(DISTINCT CONCAT(session_key,'-',event_ts,'-',event_name)) AS duplicates
FROM `sunny-web-483615-q0.stg.events`
