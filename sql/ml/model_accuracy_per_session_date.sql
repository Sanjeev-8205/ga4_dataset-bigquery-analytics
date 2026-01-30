--model_accuracy_per_session_date.sql
--Purpose: To calculate the model accuracy for each session_date
--Source: ML.backtest_predictions

SELECT
  session_date,
  COUNTIF(revenue_up=forecasted_revenue_up)/COUNT(*) AS accuracy
FROM `sunny-web-483615-q0.ML.backtest_predictions`
GROUP BY session_date
ORDER BY accuracy DESC
