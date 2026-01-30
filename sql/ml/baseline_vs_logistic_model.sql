--baseline_vs_logistic_model.sql
--Purpose: TO compare the accuracy, precision and recall of each model.
--Source: ML.backtest_predictions
--Note: A gap of +20% to +30% in accuracy suggests that the logistic model is strong compared to the baseline models.

WITH all_model AS(
  SELECT
    'baseline_model' AS model,
    CASE WHEN revenue_7d>revenue_14d THEN 1 ELSE 0 END AS pred,
    revenue_up
  FROM `sunny-web-483615-q0.ML.backtest_predictions`

  UNION ALL

  SELECT
    'always_up',
    1,
    revenue_up
  FROM `sunny-web-483615-q0.ML.backtest_predictions`

  UNION ALL

  SELECT
    'logistic_model' AS model,
    forecasted_revenue_up,
    revenue_up
  FROM `sunny-web-483615-q0.ML.backtest_predictions`

)
SELECT
  model,
  AVG(CASE WHEN revenue_up=pred THEN 1 ELSE 0 END) AS accuracy,
  SAFE_DIVIDE(SUM(CASE WHEN revenue_up=1 AND pred=1 THEN 1 ELSE 0 END), SUM(CASE WHEN pred=1 THEN 1 ELSE 0 END)) AS precision,
  SAFE_DIVIDE(SUM(CASE WHEN revenue_up=1 AND pred=1 THEN 1 ELSE 0 END), SUM(CASE WHEN revenue_up=1 THEN 1 ELSE 0 END)) AS recall
FROM all_model
GROUP BY model
