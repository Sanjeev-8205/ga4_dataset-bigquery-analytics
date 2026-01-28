--top_10_dropoff_pages_overall.sql
--Purpose: To aggregate the top 10 daily dropoff pages based on number of users.
--Source: mart.fct_dropoff_pages_daily
--Note: The url is converted to short names for a clean look.

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.top_10_dropoff_page_overall` AS
WITH dp AS(
SELECT
  dropoff_page,
  CAST(SUM(no_of_users) AS INT64) AS no_of_users
FROM `sunny-web-483615-q0.mart.fct_dropoff_pages_daily`
GROUP BY dropoff_page
ORDER BY no_of_users DESC LIMIT 10
)
SELECT
  CASE
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Apparel/Mens' THEN 'Mens Apparel'
    WHEN dropoff_page='NO_DROPOFF/PURCHASE COMPLETED' THEN 'Purchase Completed (No Dropoff)'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Apparel/Hats' THEN 'Hats'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/yourinfo.html' THEN 'Your Info(Checkout)'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Apparel' THEN 'Apparel (Category)'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Shop+by+Brand/YouTube' THEN 'Youtube Brand Page'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Clearance' THEN 'Clearance'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/store.html' THEN 'Home/Store'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/Google+Redesign/Apparel/Womens' THEN 'Womens Apparel'
    WHEN dropoff_page='https://shop.googlemerchandisestore.com/payment.html' THEN 'Payment Page'
  END AS dropoff_page,
  no_of_users
FROM dp
