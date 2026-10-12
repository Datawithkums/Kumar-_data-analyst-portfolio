
-- Project: Zomato Restaurant Data Analysis
-- Database: MySQL
-- Purpose: Explore restaurant data and generate business insights

-- 1. Preview the dataset
SELECT *
FROM zomato
LIMIT 10;

-- 2. Count total restaurants
SELECT COUNT(*) AS total_restaurants
FROM zomato;

-- 3. Check restaurant ratings
SELECT
    rate,
    COUNT(*) AS restaurant_count
FROM zomato
GROUP BY rate
ORDER BY restaurant_count DESC;

-- 4. Analyze average cost for two
SELECT
    AVG(approx_cost_for_two) AS average_cost_for_two
FROM zomato;

-- 5. Compare online ordering availability
SELECT
    online_order,
    COUNT(*) AS restaurant_count
FROM zomato
GROUP BY online_order;

-- 6. Find the most common restaurant locations
SELECT
    location,
    COUNT(*) AS restaurant_count
FROM zomato
GROUP BY location
ORDER BY restaurant_count DESC
LIMIT 10;
