--create_fct_retention_by_channel.sql
--Purpose: To track the daily number of returning users and aggregate the daily retetion percentage for D1, D7, D30.
--Grain: 1 row per different combination of cohort_date, channel and days since cohort date
--Primary Key: cohort_date, channel, days_since
--Source: stg.events
--Note:
-- -channel is derived from the combinations of source, medium, campaign form the stg.events table.

CREATE OR REPLACE TABLE `sunny-web-483615-q0.mart.fct_retention_by_channel` AS
WITH cohort_dt AS(
  SELECT
    user_key,MIN(event_date) AS cohort_date
  FROM `sunny-web-483615-q0.stg.events`s
  GROUP BY user_key
),
channels AS(
  SELECT
    cd.user_key,
    cd.cohort_date,
    CASE
      WHEN source = '(direct)' AND medium = '(none)'
        THEN 'Direct'

      WHEN medium = 'organic'
        THEN 'Organic Search'

      WHEN medium IN ('cpc','ppc')
        THEN 'Paid Search'

      WHEN medium = 'referral'
        THEN 'Referral'

      WHEN source = 'unknown_privacy'
        OR medium = 'unknown_privacy'
        OR campaign = 'unknown_privacy'
        THEN 'Unassigned'

      ELSE 'Other'
    END AS channel
  FROM `sunny-web-483615-q0.stg.events` AS ev
  JOIN cohort_dt AS cd ON ev.user_key=cd.user_key AND ev.event_date=cd.cohort_date
  QUALIFY ROW_NUMBER() OVER(PARTITION BY ev.user_key ORDER BY event_ts)=1
),
cohort_size AS(
  SELECT
    cohort_date,channel,COUNT(user_key) AS cohort_users
  FROM channels
  GROUP BY cohort_date,channel
),
returning_users AS(
  SELECT
    ch.cohort_date,
    ch.channel,
    DATE_DIFF(ev.event_date,ch.cohort_date,DAY) AS days_since,
    ch.user_key
  FROM channels AS ch
  JOIN `sunny-web-483615-q0.stg.events` AS ev ON ch.user_key=ev.user_key
  WHERE DATE_DIFF(ev.event_date,ch.cohort_date,DAY) IN(1,7,30)
),
retention_counts AS(
  SELECT
    cohort_date,channel,days_since,
    COUNT(DISTINCT user_key) AS distinct_returning_users
  FROM returning_users
  GROUP BY cohort_date,channel,days_since
)
SELECT
  cs.cohort_date,
  cs.channel,
  cs.cohort_users,
  rc.days_since,
  rc.distinct_returning_users AS returning_users,
  SAFE_DIVIDE(COALESCE(distinct_returning_users,0),cs.cohort_users) AS retention_rate
FROM cohort_size AS cs
JOIN retention_counts AS rc ON cs.cohort_date=rc.cohort_date AND cs.channel=rc.channel
ORDER BY cs.cohort_date,cs.channel,rc.days_since
