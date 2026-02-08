# Looker Studio Dashboards (GA4 E-Commerce Analytics)

This folder contains snapshots of **four Looker Studio dashboard pages** built on top of the curated **BigQuery mart layer**.
Each dashboard answers a focused set of business questions related to **user funnel behavior, channel performance, drop-off diagnostics, and retention**.

The dashboards are designed to be **executive-friendly**, **filterable by date**, and **directly backed by analytical fact tables** created in BigQuery.

---

## Funnel Overview (GA4 E-Commerce)

**Goal:** Understand how users move through the checkout funnel and where they drop off.

### Key Questions Answered

* What percentage of users reach each funnel step daily?
* What is the overall funnel completion rate?
* Which funnel step has the highest drop-off?
* How many steps do users complete on average before dropping?
* Do users who reach the payment step usually purchase or drop?

### Key Metrics & Visuals

* KPI cards: Users Entered, Purchasing Users, Funnel Completion Rate, Avg Steps Completed
* Funnel step flow banner (View Item → Purchase)
* Time-series: % of users reaching each funnel step
* Bar chart: Drop-off count by last completed step
* Donut chart: Payment step outcome (Purchased vs Dropped)

### Primary Data Sources

* `mart.fct_funnel_steps_daily`
* `mart.fct_dropoff_pages_daily`

---

## Channel Performance

**Goal:** Evaluate acquisition channel effectiveness in terms of revenue and conversion.

### Key Questions Answered

* Which channels drive the most revenue?
* Which channel has the highest conversion rate?
* How do Direct, Organic, Paid, Referral channels compare?
* Do Unassigned / Other channels perform worse?

### Key Metrics & Visuals

* KPI cards: Total Revenue, Channel Purchasers, Total Purchases, Overall Conversion Rate
* Time-series: Revenue trend by channel
* Bar chart: Conversion rate by channel
* Table: Channel-level revenue, purchasers, purchases, conversion rate

### Primary Data Source

* `mart.fct_channel_performance_daily`

---

## Drop-Off Diagnostics

**Goal:** Identify UX bottlenecks and pages causing maximum user drop-off.

### Key Questions Answered

* How many total drop-offs occurred?
* Which funnel step causes the most drop-off?
* Which pages see the highest drop-off?
* For each funnel step, what is the most common drop-off page?

### Key Metrics & Visuals

* KPI cards: Total Drop-offs, Top Drop-off Funnel Step, Top Drop-off Page
* Bar chart: Drop-off count by last completed step
* Table: Top 10 drop-off pages
* Table: Most common drop-off page per funnel step

### Primary Data Source

* `mart.fct_dropoff_pages_daily`

---

## Retention Overview (D1, D7, D30)

**Goal:** Measure user stickiness and retention quality over time.

### Key Questions Answered

* What are overall D1, D7, D30 retention rates?
* How does retention change across cohort dates?
* Is retention improving or declining over time?
* Which channels have better D7 retention?

### Key Metrics & Visuals

* KPI cards: Total Cohort Users, D1 / D7 / D30 Retention Rates
* Time-series: Retention trend by cohort date and days since
* Bar chart: D7 retention rate by channel
* Table: Detailed cohort retention breakdown

### Primary Data Sources

* `mart.fct_retention_cohorts`
* `mart.fct_retention_by_channel`

---

## Dashboard Design Notes

* All dashboards use a **global date range control**
* Metrics are computed in **BigQuery marts**, not in Looker Studio
* Dashboards are **read-only** and intended for analysis & storytelling
* Cross-filtering is selectively enabled to avoid KPI distortion

---

## Live Dashboard

A public (view-only) Looker Studio report link is provided in the **main project README**.

* Write a **killer GitHub project description**
* Prepare **interview talking points** for each dashboard
* Or design **Project 3 (ML / prediction) using this mart layer**

You’ve genuinely built something solid here 👏
