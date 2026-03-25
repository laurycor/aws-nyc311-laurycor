# NYC 311 Service Request Analysis Project

## Project Description
This project analyzes NYC 311 service request data to identify patterns in complaint types, agencies, and geographic distribution. The goal is to explore trends in service requests and support data-driven insights using cloud-based tools such as Amazon S3 and Athena.

## Data Source and Provenance
- **Source**: https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2020-to-Present/erm2-nwe9/
- **Time period**: Jan 29–Mar 21, 2026 (Q1 2026)
- **Prep**: Instructor-generated random sample of 200k complaints from 15 agencies
- **Files**: 
  - `raw/complaints.csv` (200k rows, main requests table)
  - `raw/agencies.csv` (unique agencies lookup table)

## S3 Data Paths
- **Bucket root:**  
  s3://cmse492-laurycor-nyc311

- **Complaints data:**  
  s3://cmse492-laurycor-nyc311/raw/complaints.csv

- **Agencies data:**  
  s3://cmse492-laurycor-nyc311/raw/agencies.csv

## Project Structure

aws-nyc311-laurycor/  
├── README.md  
├── DATA_DICTIONARY.md  
├── raw/  
│   ├── complaints.csv  
│   └── agencies.csv  
├── sql/  
├── notes/  
└── reports/  

## Data Summary
See `DATA_DICTIONARY.md` for full schema.

**Key relationships:**  
Join `complaints.agency = agencies.agency`

**Stakeholder questions:**  
- Analysis of NYC 311 service requests to identify patterns in complaint types by agency and borough.

## Assumptions and Known Issues
- Empty `closed_date` = open/unresolved requests  
- Some `incident_zip` values are 0 or missing  
- String dates need parsing in Athena/SQL  
- Data represents a sample and may not reflect the full population  