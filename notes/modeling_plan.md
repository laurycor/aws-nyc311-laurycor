# NYC 311 Modeling Plan

**Date created:** April 1, 2026

## Business question
Predict whether a 311 complaint will be resolved within 3 days based on complaint type, location, and time of filing.

## Data source
- **S3 path:** s3://cmse492-laurycor-nyc311-064574528604-us-east-1-an/modeling/resolution_speed_modeling.csv
- **Records:** 173870
- **Athena query:** sql/athena_to_modeling.sql

## Features
- agency (string) - the agency responsible for handling the complaint
- borough (string) - the NYC borough where the complaint was filed
- problem (string) - the specific problem type reported
- incident_zip (string) - the zip code of the incident, 1768 missing values
- day_of_week (numeric) - day of the week the complaint was created (1=Monday, 7=Sunday)
- hour_of_day (numeric) - hour of the day the complaint was created (0-23)
- problem_category (string) - broad category of the problem (housing, noise, traffic, sanitation, other)

## Target
- **Name:** resolved_quickly
- **Type:** Binary Classification (1=resolved within 3 days, 0=not resolved within 3 days)
- **Balance/Distribution:** 84.06% resolved quickly (1), 15.94% not resolved quickly (0) — imbalanced dataset

## Modeling approach
- **Baseline:** Logistic regression (interpretable, fast to train)
- **Metrics:** Accuracy, precision, recall (accuracy alone insufficient due to class imbalance)
- **Train/test split:** 80/20

## Data quality notes
- Filtered to only include complaints with a closed_date
- Filtered to 5 NYC boroughs only
- problem_category reduces high cardinality of problem field
- incident_zip has 1,768 missing values (~1% of data)
- Dataset is imbalanced: 84% positive class — may need to account for this during modeling

## Next steps
- Train/test split
- Fit baseline logistic regression
- Evaluate using precision, recall, and F1 due to class imbalance
- Evaluate and interpret results
