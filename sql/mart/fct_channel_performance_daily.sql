--fct_channel_performance_daiy.sql
--Purpose: Fact table focusing on the each day channel performance and session conversion rate
--Grain: unique(source, medium, campaign) on each session_date 
--Primary Key: session_date, source, medium, campaign
--Source:stg.events and mart.fct_sessions
--Note: Different Combinations of source, medium, campaign on each session_date is the grain. session_users is derived from the mart.fct_sessions.
-- - The channels are derived form different combinations of source, medium, campaign.

CREATE OR REPLACE TABLE `sunny-web-483615-q0.mart.fct_channel_performance_daily` AS
WITH daily_session_agg AS(
  SELECT
    session_date,
    session_key,
    user_key,
    CASE
      WHEN source IS NULL THEN '(direct)'
      WHEN source='(data deleted)' THEN 'unknown_privacy'
      WHEN source='<Other>' THEN 'Other'
      ELSE `source`
    END AS `source`,
    CASE
      WHEN medium IS NULL THEN '(direct)'
      WHEN medium='(data deleted)' THEN 'unknown_privacy'
      WHEN medium='<Other>' THEN 'Other'
      ELSE medium
    END AS medium,
    CASE
      WHEN campaign='<Other>' THEN 'Other'
      WHEN campaign='(data deleted)' THEN 'unknown_privacy'
      ELSE campaign
    END AS campaign
  FROM `sunny-web-483615-q0.mart.fct_sessions`
  GROUP BY session_date,session_key,user_key,
    source,medium,campaign
),
daily_purchases_agg AS(
  SELECT
  user_key,
  session_key,
  event_date,
  CASE
      WHEN source IS NULL THEN '(direct)'
      WHEN source='(data deleted)' THEN 'unknown_privacy'
      WHEN source='<Other>' THEN 'Other'
      ELSE `source`
    END AS `source`,
    CASE
      WHEN medium IS NULL THEN '(direct)'
      WHEN medium='(data deleted)' THEN 'unknown_privacy'
      WHEN medium='<Other>' THEN 'Other'
      ELSE medium
    END AS medium,
    CASE
      WHEN campaign='<Other>' THEN 'Other'
      WHEN campaign='(data deleted)' THEN 'unknown_privacy'
      ELSE campaign
    END AS campaign,
  COALESCE(purchase_revenue,0) AS purchase_revenue
  FROM `sunny-web-483615-q0.stg.events`
  WHERE event_name='purchase'
)
SELECT
  dsa.session_date,
  dsa.source,
  dsa.medium,dsa.campaign,
  CASE
    WHEN dsa.source = '(direct)' AND dsa.medium = '(none)'
      THEN 'Direct'

    WHEN dsa.medium = 'organic'
      THEN 'Organic Search'

    WHEN dsa.medium IN ('cpc','ppc')
      THEN 'Paid Search'

    WHEN dsa.medium = 'referral'
      THEN 'Referral'

    WHEN dsa.source = 'unknown_privacy'
      OR dsa.medium = 'unknown_privacy'
      OR dsa.campaign = 'unknown_privacy'
      THEN 'Unassigned'

    ELSE 'Other'
  END AS channel,

  COUNT(distinct dpa.user_key) purchasers,
  COUNT(distinct dsa.user_key) session_users,
  COUNT(*) AS purchases,
  SUM(COALESCE(dpa.purchase_revenue,0)) AS revenue,
  SAFE_DIVIDE(COUNT(distinct dpa.user_key),COUNT( distinct dsa.user_key)) AS conversion_rate
FROM daily_session_agg AS dsa
LEFT JOIN daily_purchases_agg AS dpa ON dsa.session_key=dpa.session_key AND dsa.user_key=dpa.user_key AND dsa.session_date=dpa.event_date
GROUP BY dsa.session_date,dsa.source,dsa.medium,dsa.campaign
ORDER BY dsa.session_date
