--model_evaluation.sql
--Purpose: To evaluate the model based on different metrics.
--Note: Evaluate the model using the December month dates instead of November.

SELECT
  *
FROM ML.EVALUATE(
  MODEL `sunny-web-483615-q0.ML.channel_revenue_direction_lr`,
  (
    SELECT
      channel,
      session_users,
      purchases,
      revenue,
      revenue_7d,
      revenue_14d,
      revenue_30d,
      conversion_rate,
      revenue_tomorrow,
      revenue_up
    FROM `sunny-web-483615-q0.ML.mart_channel_ml_features`
    WHERE session_date>='2020-12-01'
  )
);
