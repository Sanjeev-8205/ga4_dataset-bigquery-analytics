--model_probabiltiy_bucket.sql
--Purpose: To find the actual revenue up for each probability bucket.
--Grain: 1 row 1 probability bucket(eg -> 0.0-0.1 or 0.7-0.8)
--Source: ML.backtest_predictions

SELECT
  CONCAT(
    CAST(FLOOR(predicted_revenue_up_probs.prob*10)/10 AS STRING),
    '-',
    CAST(FLOOR(predicted_revenue_up_probs.prob*10)/10+0.1 AS STRING)
  ) AS prob_bucket,

  COUNT(*) AS total_predictions,
  AVG(revenue_up) AS actual_up_rate
FROM `sunny-web-483615-q0.ML.backtest_predictions`
GROUP BY prob_bucket
ORDER BY prob_bucket
