--create_fct_dropoff_pages_daily.sql
--Purpose: To aggregate daily number of users by funnel step and dropoff_page.
--Grain: 1 row per unique combination of event_date, last_completed_step and dropoff_page.
--Primary Key: event_date, last_completed_step, dropoff_page
--Source: stg.events
--Note: -The last_completed_step is derived from the user funnel progression.
-- -dropff_page represents the final page before the user exits the funnel.

CREATE TABLE `sunny-web-483615-q0.mart.fct_dropoff_pages_daily` AS
WITH daily_agg AS(
  SELECT
    event_date,
    user_key,
    ARRAY_AGG(event_name ORDER BY event_ts DESC LIMIT 1)[OFFSET(0)] AS last_completed_step,
    ARRAY_AGG(page_location ORDER BY event_ts DESC LIMIT 1)[OFFSET(0)] AS page_location
  FROM `sunny-web-483615-q0.stg.events`
  WHERE event_name IN ('view_item','add_to_cart','begin_checkout','add_shipping_info','add_payment_info','purchase')
  GROUP BY event_date, user_key
)
SELECT
  event_date,last_completed_step,
  CASE
    WHEN last_completed_step='purchase' THEN 'NO_DROPOFF/PURCHASE COMPLETED'
    ELSE page_location
  END AS dropoff_page,
  COUNT(DISTINCT user_key) AS no_of_users
FROM daily_agg
GROUP BY event_date,last_completed_step,dropoff_page
ORDER BY event_date
