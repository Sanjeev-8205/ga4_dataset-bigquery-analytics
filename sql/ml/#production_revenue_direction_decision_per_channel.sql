--#production_revenue_direction_decision_per_channel.sql
--Purpose: To calculate the different confidence predictions for each channel
--Source: ML.backtest_predictions

SELECT
  channel,
  buckets,
  COUNT(*) AS total_cases,
  AVG(revenue_up) AS avg_revenue_up
FROM(
  SELECT
    session_date,
    channel,
    revenue_up,
    CASE
      WHEN forecasted_revenue_up>=0.7 THEN 'HIGH'
      WHEN forecasted_Revenue_up>=0.6 THEN 'MEDIUM'
      ELSE 'LOW'
    END AS buckets,
  FROM sunny-web-483615-q0.ML.backtest_predictions
)
GROUP BY channel,buckets
ORDER BY channel,buckets
