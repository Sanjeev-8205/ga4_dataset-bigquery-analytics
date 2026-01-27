SQL files for staging.

Contains the files used to create the stg dataset and stg_events_table.

The stg_events is created from the raw view.
Stg is the cleaned and transformed form of the raw view which is made ready to use for further uses in mart and analytics.
The Looker Studio also uses the stg_events_table to create visual charts.

Note:- This is a very important step as rest of the tables tend to stem from this part.
