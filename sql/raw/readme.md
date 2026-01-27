## RAW Layer
Contains sql files used to create the **RAW layer**.

## Dataset
- `create_raw_dataset.sql`
  Creates the `raw` dataset in BigQuery.

## View
- `raw_source_view.sql`
  Creates a raw view referencing the main source `bigquery-public-data.ga4_obfuscated_sample_ecommerce`

## Notes
- The raw view is derived by referencing the main source.
- This view serves as the starting point and the staging tables is created using this view.
