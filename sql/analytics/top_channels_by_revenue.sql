--top_channels_by_revenue.sql
--Purpose: To aggregate the top channels by revenue.
--Source: mart.fct_channel_performance_daily

CREATE OR REPLACE VIEW `sunny-web-483615-q0.analytics.top_channels_by_revenue` AS 
SELECT
  channel,
  SUM(revenue) AS revenue
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
GROUP BY channel
ORDER BY revenue DESC;
