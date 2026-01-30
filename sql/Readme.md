## SQL Layer Overview
This folder contains all the sql files used to build the GA4 Analytics Project. The SQL is organised in a layered ELT approach.

### Folder Structure
- `raw/`
   Raw is a source-aligned view referencing the GA4 Public Dataset.
   No transformations or cleaning is done here.

- `stg/`
   Staging transformation that clean and standardize the raw events.

- `mart/`
   Mart contains business fact tables.
   This is used by analytical queries and referenced by the Looker Studio to create dashboards.

- `analytics/`
   Analytical queries used to answer specific business questions and validate the insights shown in dashboard.

- `dq/`
   Data Quality queries to check and validate the realiability and consistency of the data across layers.

### Execution Order
- `raw/` (views)
- `stg/` (tables)
- `mart/` (tables)
- `analytics/` (views)
- `dq/` (saved queries)

### Notes
- All the transformations are done in BigQuery SQL.
- The mart layer layer serves as the single source of truth for the dashboards.
