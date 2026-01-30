--label_creation.sql
--Purpose: To create a label which returns 1 when tomorrows revenue is greater than today's revenue.
--Grain: 1 row per session_date and channel
--Source: mart.fct_channel_performance_daily
--Note: roling_averages(7 days, 14 days, 30 days) are created to improve prediction.

CREATE OR REPLACE TABLE `sunny-web-483615-q0.ML.mart_channel_ml_features` AS
WITH ordered_data AS(
  SELECT
    session_date,
    channel,
    SUM(session_users) AS session_users,
    SUM(purchases) AS purchases,
    SAFE_DIVIDE(SUM(purchasers),SUM(session_users)) AS conversion_rate,
    SUM(revenue) AS revenue
  FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
  GROUP BY session_date,channel
),
rolling_revenues_and_tom_rev AS(
  SELECT
    *,
    AVG(revenue) OVER(PARTITION BY channel ORDER BY session_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS revenue_7d,
    AVG(revenue) OVER(PARTITION BY channel ORDER BY session_date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS revenue_14d,
    AVG(revenue) OVER(PARTITION BY channel ORDER BY session_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS revenue_30d,
    LEAD(revenue,1) OVER(PARTITION BY channel ORDER BY session_date) AS revenue_tomorrow
  FROM ordered_data
)
SELECT
  *,
  CASE
    WHEN revenue<revenue_tomorrow THEN 1
    ELSE 0
  END AS revenue_up
FROM rolling_revenues_and_tom_rev
WHERE revenue_tomorrow IS NOT NULL;
