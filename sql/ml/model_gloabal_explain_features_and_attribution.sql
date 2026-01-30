--model_global_explain_features_and_attribution.sql
--Purpose: To check the attribution of each features.

SELECT
  *
FROM ML.GLOBAL_EXPLAIN(
  MODEL `sunny-web-483615-q0.ML.channel_revenue_direction_lr`
);
