

-- ============================================================
-- PROJECT: Zomato Restaurant Data Analysis
-- DATABASE: MySQL
-- TABLE: zomato_dataset
-- PURPOSE: Explore restaurant data and generate business insights
-- ============================================================


-- ANALYSIS 1: Dataset Overview
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT RestaurantID) AS unique_restaurants,
    COUNT(DISTINCT City) AS unique_cities
FROM zomato_dataset;


-- ANALYSIS 2: Restaurant Rating Distribution
SELECT
    Rating,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
GROUP BY Rating
ORDER BY restaurant_count DESC;


-- ANALYSIS 3: Rating Summary (Rating > 1)
SELECT
    COUNT(*) AS rated_restaurants,
    ROUND(AVG(CAST(Rating AS DECIMAL(3,1))), 2)
        AS average_rating,
    MIN(CAST(Rating AS DECIMAL(3,1))) AS minimum_rating,
    MAX(CAST(Rating AS DECIMAL(3,1))) AS maximum_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1;


-- ANALYSIS 4: Top 10 Cities by Restaurant Count
SELECT
    City,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
GROUP BY City
ORDER BY restaurant_count DESC
LIMIT 10;


-- ANALYSIS 5: Online Delivery Availability
SELECT
    Has_Online_delivery,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_dataset),
        2
    ) AS percentage
FROM zomato_dataset
GROUP BY Has_Online_delivery
ORDER BY restaurant_count DESC;


-- ANALYSIS 6: Price Range Distribution
SELECT
    Price_range,
    COUNT(*) AS restaurant_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_dataset),
        2
    ) AS percentage
FROM zomato_dataset
GROUP BY Price_range
ORDER BY restaurant_count DESC;


-- ANALYSIS 7: Average Cost by Currency
SELECT
    Currency,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(Average_Cost_for_two), 2)
        AS average_cost_for_two,
    MIN(Average_Cost_for_two) AS minimum_cost,
    MAX(Average_Cost_for_two) AS maximum_cost
FROM zomato_dataset
GROUP BY Currency
ORDER BY restaurant_count DESC;


-- ANALYSIS 8: Zero-Cost Records
SELECT
    Currency,
    COUNT(*) AS zero_cost_records
FROM zomato_dataset
WHERE Average_Cost_for_two = 0
GROUP BY Currency
ORDER BY zero_cost_records DESC;


-- ANALYSIS 9: Top 10 Cuisine Labels by Restaurant Count
SELECT
    Cuisines,
    COUNT(*) AS restaurant_count
FROM zomato_dataset
WHERE Cuisines IS NOT NULL
GROUP BY Cuisines
ORDER BY restaurant_count DESC
LIMIT 10;


-- ANALYSIS 10: City-wise Average Ratings
SELECT
    City,
    COUNT(*) AS restaurant_count,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(3,1))), 2
    ) AS average_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1
GROUP BY City
HAVING COUNT(*) >= 50
ORDER BY average_rating DESC
LIMIT 10;


-- ANALYSIS 11: Online Delivery vs Average Rating
SELECT
    Has_Online_delivery,
    COUNT(*) AS rated_restaurants,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(3,1))), 2
    ) AS average_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1
GROUP BY Has_Online_delivery
ORDER BY average_rating DESC;


-- ANALYSIS 12: Cuisine-wise Average Ratings
SELECT
    Cuisines,
    COUNT(*) AS restaurant_count,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(3,1))), 2
    ) AS average_rating
FROM zomato_dataset
WHERE CAST(Rating AS DECIMAL(3,1)) > 1
  AND Cuisines IS NOT NULL
GROUP BY Cuisines
HAVING COUNT(*) >= 30
ORDER BY average_rating DESC
LIMIT 10;


-- ANALYSIS 13: Top 10 Restaurants by Customer Votes
SELECT
    RestaurantName,
    City,
    Cuisines,
    Votes,
    CAST(Rating AS DECIMAL(3,1)) AS Rating
FROM zomato_dataset
WHERE Votes IS NOT NULL
ORDER BY Votes DESC
LIMIT 10;
