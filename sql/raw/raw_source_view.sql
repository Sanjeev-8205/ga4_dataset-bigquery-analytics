--raw_source_view.sql
--GA4 raw view referencing the source
--no business logic or data manipuations

CREATE OR REPLACE VIEW `sunny-web-483615-q0.raw.events` AS
SELECT
  *
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;
