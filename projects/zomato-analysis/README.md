# Zomato Restaurant Data Analysis

## Project Overview
This project analyzes restaurant data to identify patterns in restaurant ratings, pricing, cuisines, and online delivery availability.

## Business Objectives
- Understand restaurant rating distributions.
- Analyze restaurant pricing patterns.
- Identify popular cuisines.
- Examine online delivery availability.
- Generate actionable business insights.

## Tools Used
- MySQL
- SQL
- GitHub

## Project Status
In progress — SQL analysis and findings will be added as the project develops.

## Repository Contents
- `README.md` — Project overview and documentation
- `zomato_analysis.sql` — SQL queries
- `insights.md` — Findings and business recommendations

## Expected Outcome
A documented, reproducible SQL analysis demonstrating practical data querying and business problem-solving skills.

## Analysis 1: Restaurant Rating Summary

### Business Question
What is the average restaurant rating when records with a rating of 1 are excluded?

### SQL Query
```sql
SELECT
    COUNT(*) AS rated_restaurants,
    ROUND(AVG(CAST(Rating AS DECIMAL(3,1))), 2) AS average_rating,
    MIN(CAST(Rating AS DECIMAL(3,1))) AS minimum_rating,
    MAX(CAST(Rating AS DECIMAL(3,1))) AS maximum_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1;
```

### Results
- Records analyzed: 7,403
- Average rating: 3.44
- Minimum rating: 1.8
- Maximum rating: 4.9

### Business Insight
The analyzed records have an average rating of 3.44, with ratings ranging from 1.8 to 4.9. Further analysis is needed to compare ratings across cities, cuisines, and price ranges.

### Methodology Note
Records with a rating of 1 were excluded for this analysis. This filter does not establish that those records contain invalid ratings.
