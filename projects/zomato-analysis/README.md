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

## Analysis 2: City-wise Restaurant Distribution

### Business Question
Which cities have the highest number of restaurant records?

### SQL Query
```sql
SELECT
    City,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
GROUP BY City
ORDER BY restaurant_count DESC
LIMIT 10;
```

### Results

| City | Restaurant Records |
|---|---:|
| New Delhi | 5,473 |
| Gurgaon | 1,118 |
| Noida | 1,080 |
| Faridabad | 251 |
| Ghaziabad | 25 |

### Business Insight
New Delhi has the highest number of restaurant records in the dataset, followed by Gurgaon and Noida. This indicates a strong concentration of records in these cities.

### Business Recommendation
Further investigate city-level ratings, price ranges, and online delivery availability to understand how restaurant supply and customer ratings vary across locations.

### Methodology Note
These figures represent restaurant records grouped by city. They should not be interpreted as current market share or total real-world restaurant counts.

## Analysis 3: Online Delivery Availability

### Business Question
How many restaurant records indicate online delivery availability?

### SQL Query
```sql
SELECT
    Has_Online_delivery,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
GROUP BY Has_Online_delivery
ORDER BY restaurant_count DESC;
```

### Results

| Online Delivery | Restaurant Records | Percentage |
|---|---:|---:|
| No | 7,100 | 74.34% |
| Yes | 2,451 | 25.66% |
| **Total** | **9,551** | **100.00%** |

### Business Insight
Approximately 25.66% of restaurant records indicate online delivery availability, while 74.34% are marked as unavailable.

### Business Recommendation
Compare delivery availability by city, rating, and price range to identify patterns and potential areas for further investigation.

## Analysis 4: Restaurant Price Range Distribution

### Business Question
Which price range contains the largest number of restaurant records?

### SQL Query
```sql
SELECT
    Price_range,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
GROUP BY Price_range
ORDER BY restaurant_count DESC;
```

### Results

| Price Range | Restaurant Records | Percentage |
|---:|---:|---:|
| 1 | 4,444 | 46.53% |
| 2 | 3,113 | 32.59% |
| 3 | 1,408 | 14.74% |
| 4 | 586 | 6.14% |
| **Total** | **9,551** | **100.00%** |

### Business Insight
Price Range 1 represents the largest category, accounting for 46.53% of restaurant records. Price Range 4 represents the smallest category at 6.14%.

### Business Recommendation
Compare price ranges with restaurant ratings, city, and online delivery availability to identify patterns in affordability and customer ratings.

### Methodology Note
Percentages are calculated using 9,551 restaurant records. Price range labels are treated as dataset categories; their exact monetary interpretation should be confirmed from the dataset documentation.


### Methodology Note
Percentages are calculated from all 9,551 records in this dataset. The results reflect the dataset's recorded values, not verified current service availability.


