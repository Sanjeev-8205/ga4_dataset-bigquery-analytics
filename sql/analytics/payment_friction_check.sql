--payment_friction_check.sql
--Purpose: To check the percentage of users who purchased and did not purchase after adding payment info.
--Source: stg.events
--Note: add_payment_info and purchase are funnel steps derived from the event_name column in stg.events table.

CREATE VIEW `sunny-web-483615-q0.analytics.payment_friction_check` AS
WITH reached_payment AS(
  SELECT
    event_date,
    user_key,
    COUNTIF(event_name='add_payment_info')>0 AS did_add_payment_info,
    COUNTIF(event_name='purchase')>0 AS did_purchase
  FROM `sunny-web-483615-q0.stg.events`
  GROUP BY event_date,user_key
)
SELECT
  SAFE_DIVIDE(COUNTIF(did_purchase=FALSE),COUNT(*)) no_purchase_after_adding_payment_info,
  SAFE_DIVIDE(COUNTIF(did_purchase=TRUE),COUNT(*)) purchase_after_adding_payment_info
FROM reached_payment
WHERE did_add_payment_info=TRUE
