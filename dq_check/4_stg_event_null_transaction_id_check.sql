--4_stg_event_null_transaction_id_check.sql
--Purpose: To check if any purchases had null transaction id.
--Source: stg.events
--Note: Zero null counts is best.

SELECT
  COUNT(*) no_of_purchases,
  COUNTIF(transaction_id IS NULL) AS null_transaction_id,
FROM `sunny-web-483615-q0.stg.events`
WHERE event_name='purchase'
