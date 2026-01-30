## Revenue Direction Prediction
This folder contains full  machine learning pipeline built on top of the GA4 mart table in BigQuery.
The objective is to predict whether the channel revenue will increase the next day and convert the predictions into confidence based decision signals.

The pipeline is fully SQL-based using BigQuery ML and is designed to be:
- Leakage-safe
- Explainable
- Backtested
- Actionable

## Problem Definition

**Business Question**

> *Will revenue for a given channel increase tomorrow compared to today?*

Instead of forecasting absolute revenue (which proved noisy and unstable), the task is framed as a **binary classification problem**:

```sql
revenue_up = 1  → revenue_tomorrow > revenue
revenue_up = 0  → revenue_tomorrow ≤ revenue
```

This framing improves generalization and enables **probability-driven decisions**.

---

## Data & Feature Engineering

**Data Source**

* GA4-derived mart tables in BigQuery

**Key Features**

* `revenue_7d_avg` — short-term revenue momentum
* `revenue_14d_avg` — medium-term revenue momentum
* `conversion_rate` — efficiency signal

All features are constructed using **past data only(November)** to avoid leakage.

---

## Model Choice

* **Model:** Logistic Regression (BigQuery ML)
* **Why:**

  * Dataset size is small (~300 rows)
  * Linear, regularized models generalize better than trees in low-data settings
  * Built-in feature standardization ensures stable coefficients

The model outputs:

* A binary prediction (`revenue_up`)
* A probability score (`prob_revenue_up`)

---

## Evaluation Strategy

### Primary Metrics

* ROC AUC
* Accuracy
* Precision
* Recall

**Final Model Performance**

* ROC AUC ≈ **0.88**
* Accuracy ≈ **0.85**
* Precision ≈ **0.87**
* Recall ≈ **0.80**

These metrics indicate strong ranking ability and balanced performance.

---

## Baseline Comparison

The model was benchmarked against simple heuristics:

1. **Momentum baseline:**
   `revenue_7d_avg > revenue_14d_avg`
2. **Always-up baseline**

**Result:**
The logistic model outperformed both baselines by **30–35 percentage points in accuracy**, demonstrating clear value beyond heuristics.

---

## Probability Calibration

Predicted probabilities were validated using **confidence buckets**:

| Probability Range | Observed Revenue Increase Rate |
| ----------------- | ------------------------------ |
| 0.0 – 0.2         | ~5–6%                          |
| 0.4 – 0.6         | ~45–55%                        |
| 0.7 – 0.8         | ~93%                           |
| 0.8 – 1.0         | ~100%                          |

This monotonic relationship confirms that **model confidence is meaningful and reliable**.

---

## Decision Logic

Based on calibration results, a **confidence-based decision rule** was defined:

```text
prob_revenue_up ≥ 0.7 → HIGH confidence signal
otherwise           → LOW confidence / no action
```

### Decision Validation (Overall)

| Bucket | Success Rate |
| ------ | ------------ |
| HIGH   | ~87%         |
| LOW    | ~13%         |

This shows that acting only on **high-confidence predictions** significantly improves outcomes.

---

## Channel-Level Diagnostics

Channel-wise analysis was performed **only for validation**, not for model tuning.

Key observation:

* High-confidence signals consistently outperform low-confidence signals across channels
* No channel exhibits contradictory behavior

Due to limited data volume, **overall metrics are treated as primary**, with channel-level results used diagnostically.

---

## Key Takeaways

* Directional classification generalizes better than revenue regression for GA4 data
* Probability calibration enables trustworthy, threshold-based decisions
* Simple, regularized models outperform complex models in low-data settings
* The final system is **decision-oriented**, not just predictive

---

## Scope & Limitations

* Model does not account for external drivers (campaign spend, promotions, seasonality)
* Predictions are best used as **signals**, not guarantees
* Thresholds are validated globally to preserve statistical stability

