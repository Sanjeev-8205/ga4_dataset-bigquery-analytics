SQL files for the mart.

This folder contains six different sql files which is used to create the main tables of the mart and another sql file which is used to create the dataset mart.


Dataset sql file - create_mart_dataset.sql(just this one)

---------mart_tables--------
1. create_fct_session.sql
2. create_fct_channel_performance_daily.sql
3. create_fct_funnel_steps_daily.sql
4. create_fct_dropoff_pages_daily.sql
5. create_fct_retention_cohorts.sql
6. create_fct_retetion_by_channel.sql

This is the order in which the mart tables were created in BigQuery.

These mart tables are further used along with stg.events table to answer different analytical questions.
