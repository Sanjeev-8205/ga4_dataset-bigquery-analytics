## SQL Layer Overview

This directory contains all SQL used to build the **GA4 Analytics Project**, organized using a layered ELT architecture.

### Folder Structure

* `raw/`
  Source-aligned views referencing the GA4 Public Dataset.
  No transformations are applied.

* `stg/`
  Staging transformations to clean, normalize, and standardize raw events.

* `mart/`
  Business-ready fact and dimension tables.
  Serves as the **single source of truth** for dashboards, analytics, and ML.

* `analytics/`
  Analytical queries used for business insights, validation, and ad-hoc analysis.

* `ml/`
  Machine-learning datasets and features derived from the mart layer, including training, inference, and evaluation outputs.

* `dq/`
  Data quality checks to validate freshness, completeness, and consistency across layers.

### Execution Order

1. `raw/` (views)
2. `stg/` (tables)
3. `mart/` (tables)
4. `analytics/` (views)
5. `ml/` (tables/views)
6. `dq/` (saved queries)

### Notes

* All transformations are written in **BigQuery SQL**.
* The mart layer is the authoritative source for Looker Studio dashboards and ML feature generation.
* ML datasets depend exclusively on the mart layer to ensure reproducibility and stability.
