## Staging Layer (Cleaned format of raw view)
This foder contains the sql files used to create the **staging layer**, which is later on referenced by mart layer tables.

## Dataset
- `create_stg_dataset.sql`
  Creates the `stg` dataset in BigQuery.

## View
- `create_stg_events_table.sql`
  Creates a cleaned and transformed table using the raw view. 

## Notes
- The staging table is derived from the raw view.
- This is a very important table used in both the **mart layer** and **Looker Studio Dashboards**.
