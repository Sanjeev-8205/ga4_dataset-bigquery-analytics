--fct_funnel_steps_daily.sql
--Purpose: To track the user funnel status and number of funnel steps completed.
--Grain: unique user per event date
--Primary: event_date,user_key
--Source: stg.events
--Note: -The funnel_status is derived from the event_name column in the stg.events.
-- -The event_name column contains many values but only these 6 values are selected
-- -event_name = view_item, add_to_cart, begin_checkout, add_shipping_info, add_payment_info, purchase as they are the most relevant steps.

CREATE TABLE `sunny-web-483615-q0.mart.fct_funnel_steps_daily` AS
WITH event_agg AS(
  SELECT
    event_date,
    user_key,
    
    COUNTIF(event_name='view_item')>0 AS did_view_item,
    COUNTIF(event_name='add_to_cart')>0 AS did_add_to_cart,
    COUNTIF(event_name='begin_checkout')>0 AS did_begin_checkout,
    COUNTIF(event_name='add_shipping_info')>0 AS did_add_shipping_info,
    COUNTIF(event_name='add_payment_info')>0 AS did_add_payment_info,
    COUNTIF(event_name='purchase')>0 AS did_purchase
  FROM `sunny-web-483615-q0.stg.events`
  GROUP BY event_date,user_key
),
funnel_daily AS (
  SELECT
    event_date,user_key,
    CAST(did_view_item AS INT64)+CAST(did_add_to_cart AS INT64)+CAST(did_begin_checkout AS INT64)+CAST(did_add_shipping_info AS INT64)+CAST(did_add_payment_info AS INT64)+CAST(did_purchase AS INT64) AS no_of_events_completed, 
    CASE
      WHEN did_purchase THEN 'purchase'
      WHEN did_add_payment_info THEN 'add_payment_info'
      WHEN did_add_shipping_info THEN 'add_shipping_info'
      WHEN did_begin_checkout THEN 'begin_checkout'
      WHEN did_add_to_cart THEN 'add_to_cart'
      WHEN did_view_item THEN 'view_item'
      ELSE 'no_funnel_events'
    END AS last_completed_step,
    CASE
      WHEN did_purchase THEN 'Completed'
      WHEN did_view_item OR did_begin_checkout OR did_add_shipping_info OR did_add_payment_info OR did_purchase THEN 'In Progress'
      ELSE 'Not Entered'
    END AS funnel_status
  FROM event_agg
)
SELECT * FROM funnel_daily;
