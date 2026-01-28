--each_funnel_most_dropped_page.sql
--Purpose: To find each funnel step's most dropped page
--Grain: 1 row per funnel step
--Source: mart.fct_dropoff_pages_daily
--Note: The url's are converted to short names for better readability.

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.each_funnel_most_dropoff_page` AS
WITH top AS(
  SELECT
    last_completed_step AS funnel_step,
    dropoff_page AS most_dropoff_page,
    SUM(no_of_users) AS no_of_users,
    ROW_NUMBER() OVER(
      PARTITION BY last_completed_step
      ORDER BY SUM(no_of_users) DESC
    ) AS ranked
  FROM `sunny-web-483615-q0.mart.fct_dropoff_pages_daily`
  GROUP BY last_completed_step,dropoff_page
  QUALIFY ranked=1
)
SELECT
  *,
  CASE
    WHEN most_dropoff_page='https://shop.googlemerchandisestore.com/payment.html' THEN 'Payment Info'
    WHEN most_dropoff_page='https://shop.googlemerchandisestore.com/yourinfo.html' THEN 'Your Info(Checkout)'
    WHEN most_dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Apparel/Hats' THEN 'Hats'
    WHEN most_dropoff_page='https://shop.googlemerchandisestore.com/yourinfo.html' THEN 'Your Info(Checkout)'
    WHEN most_dropoff_page='NO_DROPOFF/PURCHASE COMPLETED' THEN 'Purchase Completed (No Dropoff)'
    WHEN most_dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Apparel/Mens' THEN 'Mens Apparel'
  END AS short_page_name
FROM top
