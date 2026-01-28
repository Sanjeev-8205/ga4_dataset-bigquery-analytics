--top_channels_by_session_conversion_rate.sql
--Purpose: To aggregate the top channels by session conversion rate
--Source: mart.fct_channel_performance_daily

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.top_channels_by_session_conversion_rate` AS 
SELECT
  channel,
  ROUND(AVG(conversion_rate),4) AS session_conversion_rate
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
GROUP BY channel
ORDER BY session_conversion_rate DESC;
