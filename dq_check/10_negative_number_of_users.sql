--10_negative_number_of_users.sql
--Purpose: To verify that no_of_users is not negative.
--Source:mart.fct_dropoff_pages_daily
--Note: This should return 0.

SELECT
  COUNT(*) AS invalid_rows
FROM `sunny-web-483615-q0.mart.fct_dropoff_pages_daily` 
WHERE no_of_users<=0;
