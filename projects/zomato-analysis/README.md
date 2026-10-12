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

## Analysis 5: Average Cost and Data Quality

### Business Question
What is the average cost for two people, and are there any unusual cost values?

### SQL Query: Currency-wise Cost Analysis
```sql
SELECT
    Currency,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(Average_Cost_for_two), 2) AS average_cost_for_two,
    MIN(Average_Cost_for_two) AS minimum_cost,
    MAX(Average_Cost_for_two) AS maximum_cost
FROM zomato_dataset
GROUP BY Currency
ORDER BY restaurant_count DESC;
```

### Key Findings
- Indian Rupees account for 8,652 restaurant records.
- The average recorded cost for two in Indian Rupees is 623.37.
- The average recorded cost for two in US Dollars is 31.51.
- Cost values vary by currency and must not be compared directly without currency conversion.

### Data Quality Check: Zero-Cost Records
A separate query identified 18 records with `Average_Cost_for_two = 0`:
- Dollar ($): 9 records
- Indian Rupees (Rs.): 9 records

### Business Insight
Zero-cost values may represent free dining, missing values, or data-entry/default-value issues. Further verification is required before classifying these records as errors or excluding them from the analysis.

### Recommendation
Validate zero-cost records against reliable source information and perform currency-specific analysis before using cost metrics for business decisions.

## Analysis 6: Popular Cuisine Categories

### Business Question
Which cuisine categories appear most frequently in the restaurant dataset?

### SQL Query
```sql id="6ft4c2"
SELECT
    Cuisines,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
WHERE Cuisines IS NOT NULL
GROUP BY Cuisines
ORDER BY restaurant_count DESC
LIMIT 10;
```

### Results

| Cuisine Category | Restaurant Records |
|---|---:|
| North Indian | 936 |
| North Indian, Chinese | 511 |
| Chinese | 354 |
| Fast Food | 354 |
| North Indian, Mughlai | 334 |

### Business Insight
North Indian is the most frequent individual cuisine category among the top results, with 936 restaurant records. North Indian and Chinese is the most frequent combined cuisine category in this result set, with 511 records.

### Business Recommendation
Analyze ratings, price ranges, and online delivery availability across cuisine categories to understand customer preferences and business opportunities.

### Methodology Note
Combined cuisine values are treated as separate categories. A restaurant offering multiple cuisines may appear under a combined label rather than being counted separately for each cuisine.

## Analysis 7: City-wise Average Restaurant Ratings

### Business Question
Which cities have the highest average restaurant ratings among cities with at least 50 eligible records?

### SQL Query
```sql id="q4y7hw"
SELECT
    City,
    COUNT(*) AS restaurant_count,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(3,1))),
        2
    ) AS average_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1
GROUP BY City
HAVING COUNT(*) >= 50
ORDER BY average_rating DESC
LIMIT 10;
```

### Results

| City | Records Analyzed | Average Rating |
|---|---:|---:|
| Gurgaon | 890 | 3.33 |
| New Delhi | 4,048 | 3.30 |
| Noida | 696 | 3.16 |
| Faridabad | 151 | 3.10 |

### Business Insight
Gurgaon has the highest average rating among the cities returned by the query, at 3.33. New Delhi has the largest number of analyzed records, at 4,048.

### Business Recommendation
Investigate city-level cuisine, pricing, and online delivery patterns to understand factors associated with rating differences.

### Methodology Note
Records with rating 1 are excluded, and cities must have at least 50 eligible records. The results describe this filtered dataset and do not establish the cause of rating differences.

## Analysis 8: Online Delivery vs Average Restaurant Rating

### Business Question
Do restaurants offering online delivery have a higher average rating than restaurants that do not?

### SQL Query
```sql
SELECT
    Has_Online_delivery,
    COUNT(*) AS rated_restaurants,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(3,1))),
        2
    ) AS average_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1
GROUP BY Has_Online_delivery
ORDER BY average_rating DESC;
```

### Results

| Online Delivery | Restaurants Analyzed | Average Rating |
|---|---:|---:|
| No | 5,048 | 3.47 |
| Yes | 2,355 | 3.38 |

### Business Insight
Restaurants without online delivery have a slightly higher average rating (3.47) than restaurants offering online delivery (3.38), a difference of 0.09 rating points.

### Business Recommendation
Investigate customer feedback, cuisine categories, pricing, and service patterns to understand the rating difference before making operational decisions.

### Methodology Note
Only records with ratings greater than 1 were included. These results show an association in the dataset and do not prove that online delivery causes lower ratings.

## Analysis 9: Cuisine-wise Average Restaurant Ratings

### Business Question
Which cuisine categories have the highest average restaurant ratings?

### SQL Query
```sql
SELECT
    Cuisines,
    COUNT(*) AS restaurant_count,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(3,1))),
        2
    ) AS average_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1
  AND Cuisines IS NOT NULL
GROUP BY Cuisines
HAVING COUNT(*) >= 30
ORDER BY average_rating DESC
LIMIT 10;
```

### Results

| Cuisine Category | Restaurants Analyzed | Average Rating |
|---|---:|---:|
| Italian | 50 | 3.95 |
| Mexican | 34 | 3.85 |
| Desserts | 40 | 3.60 |
| Chinese \| Thai | 48 | 3.52 |
| Burger \| Fast Food | 39 | 3.49 |
| Bakery \| Desserts \| Fast Food | 61 | 3.48 |
| Beverages | 39 | 3.44 |
| Pizza | 34 | 3.44 |
| Ice Cream | 45 | 3.44 |
| Cafe | 252 | 3.43 |

### Business Insight
Italian cuisine has the highest average rating among the categories returned by this query, at 3.95, followed by Mexican cuisine at 3.85. Cafe has the largest number of analyzed restaurants among these ten categories, with 252 records.

### Business Recommendation
Restaurant businesses could investigate customer feedback and demand for highly rated cuisine categories when evaluating menu opportunities. Ratings alone do not establish customer demand or profitability.

### Methodology Note
Only records with ratings greater than 1 and non-null cuisine values were included. Each distinct cuisine string, including combinations such as `Chinese | Thai`, is treated as a separate category. Categories require at least 30 eligible records.







