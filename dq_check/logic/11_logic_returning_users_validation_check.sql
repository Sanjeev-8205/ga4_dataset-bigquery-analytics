-- 11_logic_returning_users_validation_check.sql

-- CONTRACT:
-- returning users must always be <no_of_cohort_users.
-- Any violation indicates invalid user conversion metrics.
-- This is expected to return 0 rows.

-- REQUIRED INPUTS:
-- table: mart.fct_retention_cohorts
-- filter: returning_users>no_of_cohort_users
-- critical_columns: returning_users, no_of_cohort_users

SELECT
  COUNT(*) AS invalid_rows
FROM `sunny-web-483615-q0.mart.fct_retention_cohorts`
WHERE returning_users>no_of_cohort_users;
