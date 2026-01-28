--top_dropoff_page.sql
--Purpose: To find the highest overall dropped off page.
--Source: mart.fct_droppoff_pages_daily
--Note: The #1 dropped of page is derived from the no of users dropped.

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.top_dropoff_page` AS
WITH top_dropoff_page AS(
  SELECT
    dropoff_page,
    CAST(SUM(no_of_users) AS INT64) AS no_of_users
  FROM `sunny-web-483615-q0.mart.fct_dropoff_pages_daily`
  GROUP BY dropoff_page
  ORDER BY no_of_users DESC LIMIT 1
)
SELECT
  CASE
    WHEN CONTAINS_SUBSTR(dropoff_page,'/Google+Redesign/Apparel/Mens') THEN "Mens Apparel (Category)"
  END AS dropoff_page
FROM top_dropoff_page
