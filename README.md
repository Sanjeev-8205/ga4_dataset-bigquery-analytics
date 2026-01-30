# GA4 Analytics with BigQuery, Looker Studio & BigQuery ML

This project analyzes **Google Analytics 4 (GA4) BigQuery export data** to generate actionable business insights and answer common digital analytics questions.
Analytics-ready datasets are built in **BigQuery**, visualized through **Looker Studio dashboards**, and extended with **predictive modeling using BigQuery ML**.

The project demonstrates an end-to-end analytics workflow: from raw event data to stakeholder-ready dashboards and machine learning–driven decision signals.

---

## Table of Contents

* [Project Overview](#project-overview)
* [Data Source](#data-source)
* [Project Structure](#project-structure)
* [Dashboards](#dashboards)
* [Technology Stack](#technology-stack)
* [Predictive Modeling (BigQuery ML)](#predictive-modeling-bigquery-ml)
* [How to Use This Project](#how-to-use-this-project)
* [Future Improvements](#future-improvements)

---

## Project Overview

### Key Objectives

* Transform raw GA4 event data into business-ready analytics tables
* Answer common marketing, product, and revenue analytics questions
* Provide interactive dashboards for non-technical stakeholders
* Predict short-term revenue movement using machine learning

### Analytics Themes

* Traffic acquisition & channel performance
* User engagement and behavioral patterns
* Revenue and conversion analysis
* Channel-level revenue forecasting

---

## Data Source

* **Google Analytics 4 BigQuery Export**
* Event-level GA4 data transformed into:

  * Session-level aggregates
  * Channel-level performance tables
  * Time-series features for machine learning

The data model follows a layered approach to ensure clarity, scalability, and reusability.

---

## Project Structure

```
.
├── sql/
    ├── raw/
│   ├── stg/
│   ├── mart/
|   ├── analytics/
│   └── ml/
├── Dashboard/
│   ├── screenshots/
│   └── README.md
└── README.md
```

### SQL Layers

The [`sql/`](./sql) directory contains all SQL used in the project:

* **Staging**

  * Cleans and standardizes raw GA4 event data
  * Handles nested fields and repeated records

* **Marts**

  * Builds analytics-ready fact and dimension tables
  * Optimized for BI tools, Looker Studio and reporting use cases

* **ML**

  * Feature engineering
  * Model training and evaluation using BigQuery ML

Each layer is documented in detail within the [`sql/`](./sql) directory.

---

## Dashboards

### Looker Studio Report

🔗 **Live Dashboard:**
[https://lookerstudio.google.com/reporting/d7de9022-0bc6-4e6e-a326-53b60e349e6d](https://lookerstudio.google.com/reporting/d7de9022-0bc6-4e6e-a326-53b60e349e6d)

* Built directly on BigQuery mart tables
* Interactive filters for date ranges, channels, and metrics
* Designed for both exploration and executive-level summaries

The [`dashboards/`](./Dashboard) directory includes:

* Static screenshots of each dashboard page
* A README explaining:

  * Business questions addressed
  * Key metrics and dimensions
  * How to interpret the visualizations

---

## Technology Stack

### BigQuery

* Queries GA4 export data
* Performs transformations and aggregations
* Hosts analytics-ready mart tables
* Trains and evaluates machine learning models using **BigQuery ML**

### Looker Studio

* Connects directly to BigQuery
* Provides interactive dashboards and filters

---

## Predictive Modeling (BigQuery ML)

This project extends traditional GA4 reporting with **machine learning–driven forecasting**.

### Model Objective

Predict the **probability that channel-level revenue will increase the following day**, enabling confidence-based decision making.

### Key Components

* Feature engineering from historical GA4 performance metrics
* Supervised classification using BigQuery ML
* Evaluation against heuristic and baseline approaches
* Translation of predictions into actionable confidence signals

### Documentation

All ML-related SQL scripts and explanations are located in:

```
sql/ml/
```

---

## How to Use This Project

1. Review SQL transformations in the `sql/` directory
2. Explore the live Looker Studio dashboard via the provided link
3. Use dashboard screenshots for a guided walkthrough
4. Examine ML queries to understand feature engineering and model logic
