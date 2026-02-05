## Purpose

This folder contains reusable data quality checks designed to protect analytical metrics from silent errors. Each check enforces an invariant that must always hold true for the metrics to be considered valid.

## Definition of valid data

Data is considered valid if:
- Structural integrity is maintained(eg: No null, no duplicates).
- Metric values are well within the bounds.
- Logic/relationship between metrics are consistent.

## Categories of check

### Structural Checks
Ensure the shape of the data is correct i.e. no nulls, no duplicates.

### Metric Integrity Checks
Validate metrics and rates.
(eg: revenue>0, conversiton_rate ∈ [0,1])

### Logic/Relationship Checks
Ensures the relationship between different metrics are consistent and holds.
(eg: purchases>=purchasers)

## How to use

1. Run all the metric queries to generate analytical outputs.
2. Run the relevant DQ queries to check for inconsistencies.
3. The queries are expected to return 0 rows.
4. If any violation occurs, the metric is invalid and should not be reported.

## Design Principles

Validation logic is seperated from metric computation.
Checks are enforced to be reused across different projects.
Each check enforces a single invariant.
Checks are designed to fail loudly and avoid silent passes.
