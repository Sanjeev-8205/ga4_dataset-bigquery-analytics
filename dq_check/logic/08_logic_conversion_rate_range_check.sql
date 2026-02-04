-- 08_logic_conversion_rate_range_check.sql

-- CONTRACT:
-- No out of range conversion_rate allowed.
-- Any violation indicates invalid conversion metrics.

-- REQUIRED INPUTS:
-- table: mart.fct_channel_performance_daily
-- critical_column: conversion_rate

SELECT
  COUNTIF(conversion_rate<0 OR conversion_rate>1) AS invalid_rows
FROM `sunny-web-483615-q0.mart.fct_channel_performance_daily`
