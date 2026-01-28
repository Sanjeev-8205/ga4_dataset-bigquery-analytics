## Looker Studio Dashboard

This folder contains screenshots of the Looker Studio dashboards answering specific business questions built on top of the mart tables.
The dashboards provide interactive view of user behaviour, funnel performance, channel effectiveness, dropoff diagnostics and retention

All the dashboards are powered by the mart tables, analytic views with limited use of stg.events and do not use RAW events view.

---

### Funnel Overview (Page 1)
**Purpose:**
  - Understand how users progresses through the purchase funnel and where they dropoff.
**Key Questions Answered**
  - What pecentage of users reach each funnel step daily from Nov 2020 till end of Dec 2020?
  - What is the daily funnel completion rate?
  - What is the total number of users who actually purchased?
  - What is the percentage of users who purchase and did not purchase after adding payment info?

**Primary Data Sources**
  - `mart.fct_funnel_steps_daily`
  - `stg.events`
  
### Channel Performance (Page 2)
**Purpose:**
  - Explains how each channel affected the revenue and conversion rate.
**Key Questions Answered***
  - What is the total revenue, total number of purchasers and purchases?
  - What is the daily revenue by channel?
  - WHat is the overall conversion rate per channel?

**Primary Data Sources**
  - `mart.fct_channel_performance_daily`
  
### Drop-off Diagnostics (Page 3)
**Purpose:**
  - Identify the specific funnel steps and pages which make the user abandon the journey.
**Key Questions Answered**
  - Which is the page and funnel step which cause most user drop-off?
  - What is the total number of drop-off pages?
  - What are the top 10 pages where user most drop-off and numbers of users drop-off in that specific page?

**Primary Data Sources**
- `mart.fct_dropoff_pages_daily`

### Retention (Page 4)
**Purpose:**
  - Analyze user retention over time using cohort analysis.
**Key Questions Answered**
  - What are the overall retention rates for D1, D7, D30(thirty days since cohort date)?
  - Does retention rate increase or deteriorate over cohort date?
  - Whcih channel has better overall D7 retention rate?

**Primary Data Sources**
- `mart.fct_retention_cohorts`
- `mart.fct_retention_by_channel`
