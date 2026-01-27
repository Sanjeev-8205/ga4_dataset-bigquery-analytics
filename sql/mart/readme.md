## Mart Layer (Business Tables)

This folder contains the sql files used to create the **mart layer**, which represents business-ready fact tables built on top of the staging layer.

## Dataset
 - `create_mart_dataset.sql`
   Creates the `mart` dataset in BigQuery

## Mart Tables
The following fact tables are created in the order listed below:

1. `create_fct_session.sql`
   Session level fact table one row per session.
   
2. `create_fct_channel_performance_daily.sql`
   Daily channel performance including purchases,revenue and conversion_rate.

3. `create_fct_funnel_steps_daily.sql`
   Daily user-level funnel progression and completion status.
   
4. `create_fct_dropoff_pages_daily.sql`
   Daily aggregation of user drop-offs by funnel steps and page
   
5. `create_fct_retention_cohorts.sql`
   Daily retention of the users by days since cohort date.
   
6. `create_fct_retention_by_channel.sql`
   Daily retention of the users by channel and days since cohort date.

## Notes
- All mart tables are primarily derived from `stg.events`.
- Some mart tables are also derived from other mart tables when needed.
- These tables serve as the foundation for analytical queries and Looker Studio Dashboards.
