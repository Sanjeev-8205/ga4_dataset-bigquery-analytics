--model_backtest_prediction.sql
--Purpose: To predict the labels of the December data.
--Note:
-- -Since it's a classification model, the model will predict both the labels and probabilities of each label as well.
-- -The probabilities help in decision making in the later processes.

CREATE OR REPLACE TABLE `sunny-web-483615-q0.ML.backtest_predictions` AS
WITH predictions AS(
  SELECT
    session_date,
    channel,
    predicted_revenue_up AS forecasted_revenue_up,
    predicted_revenue_up_probs[OFFSET(0)] AS predicted_revenue_up_probs
  FROM ML.PREDICT(
    MODEL `sunny-web-483615-q0.ML.channel_conversion_model`,
    (
      SELECT
        session_date,
        channel,
        session_users,
        purchases,
        revenue,
        revenue_7d,
        revenue_14d,
        revenue_30d,
        conversion_rate,
        revenue_tomorrow
      FROM `sunny-web-483615-q0.ML.mart_channel_ml_features`
      WHERE session_date>='2020-12-01'
    )
  )
  ORDER BY forecasted_revenue_up DESC
)
SELECT
  p.session_date,
  p.channel,
  m.revenue_7d,
  m.revenue_14d,
  m.revenue_tomorrow,
  m.revenue_up,
  p.forecasted_revenue_up,
  p.predicted_revenue_up_probs
FROM predictions AS p
JOIN `sunny-web-483615-q0.ML.mart_channel_ml_features` AS m ON p.session_date=m.session_date AND p.channel=m.channel
ORDER BY p.session_date
