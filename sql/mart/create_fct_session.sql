--create_fct_session.sql
--Purpose - A fact table focusing on user sessions.
--Grain: one row per session(unique session_key) 
--Primary key: user_key,session_id,session_key
--Source: stg.events
--Note: Session level attributes are derived from the first event in the session. This is used for channel performance and conversion.

CREATE TABLE `sunny-web-483615-q0.mart.fct_sessions` AS
WITH session_base AS(
  SELECT
    * EXCEPT(transaction_id,purchase_revenue,revenue_in_usd)
  FROM `sunny-web-483615-q0.stg.events`
  WHERE session_id IS NOT NULL
),
session_agg AS(
  SELECT
    user_key,
    session_id,
    session_key,

    MIN(event_date) AS session_date,
    MIN(event_ts) AS session_start_ts,
    MAX(event_ts) AS session_end_ts,

    ARRAY_AGG(page_location ORDER BY event_ts LIMIT 1)[OFFSET(0)] AS landed_page,

    ARRAY_AGG(`source` ORDER BY event_ts LIMIT 1)[OFFSET(0)] AS `source`,
    ARRAY_AGG(medium ORDER BY event_ts LIMIT 1)[OFFSET(0)] AS medium,
    ARRAY_AGG(campaign ORDER BY event_ts LIMIT 1)[OFFSET(0)] AS campaign,

    ANY_VALUE(device_category) AS device_category,
    ANY_VALUE(country) AS country
  FROM session_base
  GROUP BY user_key,session_id,session_key
)
SELECT
  *,
  TIMESTAMP_DIFF(session_end_ts, session_start_ts, SECOND) AS session_duration
FROM session_agg
