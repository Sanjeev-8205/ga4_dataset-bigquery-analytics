--create_fct_retention_cohorts.sql
--Purpose: To track the number of cohort users and returning users in D1, D7, D30 from the cohort_date and aggregate the retention percentage.
--Grain: 1 row unique combination of cohort date and days since cohort date
--Primary Key: cohort_date, days_sicne_first_event
--Source: stg.events
--Note:
-- -cohort_date is derived from users minimum event_date.
-- -cohort_users represents the number of users who marked their first event ever on that cohort_date.

CREATE TABLE `sunny-web-483615-q0.mart.fct_retention_cohorts` AS
WITH users_daily_activity AS(
  SELECT
    user_key,ARRAY_AGG(DISTINCT(event_date) ORDER BY event_date) AS event_dates
  FROM `sunny-web-483615-q0.stg.events`
  GROUP BY user_key
),
cohort_users AS(
  SELECT
    user_key,MIN(event_date) AS cohort_date_users
  FROM `sunny-web-483615-q0.stg.events`
  GROUP BY user_key
),
days_since_cohort_users_date AS(
  SELECT
    ud.user_key,
    cu.cohort_date_users,
    DATE_DIFF(ued,cu.cohort_date_users,day) AS days_since_first_event
  FROM users_daily_activity AS ud
  JOIN cohort_users AS cu ON ud.user_key=cu.user_key
  JOIN UNNEST(ud.event_dates) AS ued
  WHERE DATE_DIFF(ued,cu.cohort_date_users,day) IN(1,7,30)
),
cohort_users_sizes AS(
  SELECT
    cohort_date_users,
    COUNT(user_key) AS no_of_cohort_users
  FROM cohort_users
  GROUP BY cohort_date_users
),
retention_counts AS(
  SELECT
    cohort_date_users,
    days_since_first_event,
    COUNT(user_key) AS returning_users
  FROM days_since_cohort_users_date
  GROUP BY cohort_date_users,days_since_first_event
)
SELECT
  cus.cohort_date_users AS cohort_date,
  rc.days_since_first_event,
  cus.no_of_cohort_users,
  rc.returning_users,
  SAFE_DIVIDE(rc.returning_users,cus.no_of_cohort_users)*100 AS retention_percentage
FROM retention_counts AS rc
JOIN cohort_users_sizes AS cus ON rc.cohort_date_users=cus.cohort_date_users
ORDER BY cohort_date,days_since_first_event
