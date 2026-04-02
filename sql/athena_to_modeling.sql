-- Athena query for model data generation
-- Stakeholder question: The mayor's office wants to know whether certain types
-- of 311 complaints are likely to be resolved within 3 days — can we build a
-- model to flag fast vs. slow resolutions at intake?
--
-- Features:
--   agency           - the agency responsible for handling the complaint
--   borough          - the NYC borough where the complaint was filed
--   problem          - the specific problem type reported
--   incident_zip     - the zip code of the incident
--   day_of_week      - day of the week the complaint was created (1=Monday, 7=Sunday)
--   hour_of_day      - hour of the day the complaint was created (0-23)
--   problem_category - broad category of the problem (housing, noise, traffic, sanitation, other)
--
-- Target:
--   resolved_quickly - binary (1 = resolved within 3 days, 0 = not resolved within 3 days)

CREATE TABLE nyc311_db.resolution_speed_modeling AS
SELECT
    agency,
    borough,
    problem,
    incident_zip,
    day_of_week(date_parse(created_date, '%Y-%m-%d %H:%i:%s')) AS day_of_week,
    hour(date_parse(created_date, '%Y-%m-%d %H:%i:%s')) AS hour_of_day,
    CASE
        WHEN problem IN ('HEAT/HOT WATER','PLUMBING','WATER LEAK','PAINT/PLASTER',
                         'DOOR/WINDOW','ELECTRIC','GENERAL','UNSANITARY CONDITION') THEN 'housing'
        WHEN problem IN ('Noise - Residential','Noise - Street/Sidewalk',
                         'Noise - Commercial','Noise') THEN 'noise'
        WHEN problem IN ('Illegal Parking','Blocked Driveway','Traffic Signal Condition',
                         'Street Condition','Abandoned Vehicle') THEN 'traffic'
        WHEN problem IN ('Snow or Ice','Dirty Condition','Water System') THEN 'sanitation'
        ELSE 'other'
    END AS problem_category,
    CASE
        WHEN closed_date <> ''
         AND date_diff('day',
                date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
                date_parse(closed_date, '%Y-%m-%d %H:%i:%s')) <= 3
        THEN 1
        ELSE 0
    END AS resolved_quickly
FROM nyc311_db.complaints
WHERE closed_date <> ''
  AND borough IN ('BROOKLYN','QUEENS','BRONX','MANHATTAN','STATEN ISLAND')