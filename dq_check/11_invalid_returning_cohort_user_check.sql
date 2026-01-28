--11_invalid_returning_cohort_user_check.sql
--Purpose: To verify if the returning users and no of cohort users are valid.
--Source: mart.fct_retention_cohorts

SELECT
  COUNT(*) AS invalid_rows
FROM `sunny-web-483615-q0.mart.fct_retention_cohorts`
WHERE returning_users>no_of_cohort_users;
