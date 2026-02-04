-- 10_logic_non_positive_number_of_users_check.sql

-- CONTRACT:
-- Number of users must always be >0.
-- Any violation indicates invalid no.of users conversion metric.
-- This is expected to return 0 rows.

-- REQUIRED INPUTS:
-- filter: no_of_users<=0
-- table: mart.fct_dropoff_pages_daily
-- critical_columns: no_of_users

SELECT
  COUNT(*) AS invalid_rows
FROM `sunny-web-483615-q0.mart.fct_dropoff_pages_daily` 
WHERE no_of_users<=0;
