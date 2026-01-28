This folder contains SQL-based data quality (DQ) checks used to validate the GA4 data at both the staging (`stg`) and mart (`mart`) layers.
These checks ensure that key fields are non-null, metrics are logically consistent, funnel and retention calculations are valid, and known GA4 data nuances (such as missing transaction IDs on purchase events) are handled correctly.
All checks were executed in BigQuery prior to building analytical views and Looker Studio dashboards.
