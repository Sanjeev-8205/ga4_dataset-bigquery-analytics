--#production_revenue_direction_decision.sql
--Purpose: To aggregate the success rate of each confidence predictions.
--Grain: 1 row unique bucket
--Source: ML.backtest_predictions

CREATE OR REPLACE TABLE `sunny-web-483615-q0.ML.production_revenue_direction_decision` AS
SELECT
  buckets,
  COUNT(*) AS total_cases,
  AVG(revenue_up) AS avg_revenue_up
FROM(
  SELECT
    '2020-12-15',
    channel,
    revenue_up,
    CASE
      WHEN forecasted_revenue_up>=0.7 THEN 'HIGH'
      WHEN forecasted_Revenue_up>=0.6 THEN 'MEDIUM'
      ELSE 'LOW'
    END AS buckets,
  FROM sunny-web-483615-q0.ML.backtest_predictions
)
GROUP BY buckets
