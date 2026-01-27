--create_stg_events_table.sql
--The stg events table is created using the raw view of the main source(GA4 BigQuery Public Dataset).
--Data is cleaned and transformed for further use but no business logic is used yet.

CREATE OR REPLACE TABLE `sunny-web-483615-q0.stg.events` AS
SELECT
  PARSE_DATE('%Y%m%d',event_date) AS event_date,
  TIMESTAMP_MICROS(event_timestamp) AS event_ts,
  event_name,

  CAST(user_pseudo_id AS STRING) AS user_key,
  CAST(( SELECT ep.value.int_value
    FROM UNNEST(event_params) ep
    WHERE ep.key='ga_session_id') AS INT64) AS session_id,
  CONCAT(CAST(user_pseudo_id AS STRING), '-', ( SELECT ep.value.int_value
    FROM UNNEST(event_params) ep
    WHERE ep.key='ga_session_id' )) AS session_key,
  
  (SELECT ep.value.string_value FROM UNNEST(event_params) ep WHERE ep.key='page_location') AS page_location,
  (SELECT ep.value.string_value FROM UNNEST(event_params) ep WHERE ep.key='page_referrer') AS page_referrer,

  traffic_source.source AS source,
  traffic_source.medium AS medium,
  traffic_source.name AS campaign,

  device.category AS device_category,
  geo.country AS country,

  ecommerce.transaction_id AS transaction_id,
  ecommerce.purchase_revenue AS purchase_revenue,
  ecommerce.purchase_revenue_in_usd AS revenue_in_usd

FROM `sunny-web-483615-q0.raw.events`
WHERE PARSE_DATE('%Y%m%d',event_date)<'2021-01-01';
