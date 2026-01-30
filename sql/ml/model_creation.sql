--model_creation.sql
--Purpose: To create a classification model using logistic regression.
--Source: ML.mart_channel_ml_features
--Note: Trained the model using all the dates of November month.

CREATE OR REPLACE MODEL `sunny-web-483615-q0.ML.channel_conversion_model`
OPTIONS(
  model_type='logistic_reg',
  input_label_cols=['revenue_up'],
  enable_global_explain=TRUE,
  standardize_features=TRUE
) AS
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
WHERE session_date<='2020-11-30';
