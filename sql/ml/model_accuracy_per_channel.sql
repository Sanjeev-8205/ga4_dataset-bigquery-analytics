--model_accuracy_per_channel.sql
--Purpose: To calculate the accuracy of the model per channel.
--Grian: 1 row 1 channel
--Source: ML.backtest_predictions

SELECT
  channel,
  COUNTIF(revenue_up=forecasted_revenue_up)/COUNT(*) AS accuracy
FROM `sunny-web-483615-q0.ML.backtest_predictions`
GROUP BY channel
ORDER BY accuracy DESC
