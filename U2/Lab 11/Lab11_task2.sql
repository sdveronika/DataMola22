WITH CTE_FN AS(
SELECT /*+ gather_plan_statistics */ TRUNC ( order_date, 'MM' ) AS order_date, 
    DECODE (GROUPING(country_r), 1, 'All countries', country_r) AS country_r,
    DECODE (GROUPING(city_r), 1, 'All cities', city_r) AS city_r,
    DECODE (GROUPING(dish_name), 1, 'All dishes', dish_name) AS dish_name,
    COUNT(dish_name) AS dish_count
FROM sa_orders.sa_t_transaction
GROUP BY TRUNC ( order_date, 'MM' ),CUBE(  country_r, city_r, dish_name)
HAVING  GROUPING_ID (country_r)<1 AND GROUPING_ID (city_r)<1 
ORDER BY 1, 2, 3, 4)
SELECT order_date, country_r, city_r, dish_name, dish_count
FROM CTE_FN;

WITH CTE_FN AS(
SELECT /*+ gather_plan_statistics */ TRUNC ( date_id, 'MM' ) AS order_date, 
    DECODE (GROUPING(country), 1, 'All countries', country) AS country,
    DECODE (GROUPING(city), 1, 'All cities', city) AS city,
    DECODE (GROUPING(dish_name), 1, 'All dishes', dish_name) AS dish_name,
    COUNT(dish_name) AS dish_count
FROM dw_data.order_fact fct
LEFT JOIN dw_data.dish_dimension dsh
ON (fct.dish_id=dsh.dish_id)
LEFT JOIN dw_data.restaurant_dimension rst
ON (rst.restaurant_id=fct.restaurant_id)
GROUP BY TRUNC ( date_id, 'MM' ),CUBE(  country, city, dish_name)
HAVING  GROUPING_ID (country)<1 AND GROUPING_ID (city)<1 
ORDER BY 1, 2, 3, 4)
SELECT order_date, country, city, dish_name, dish_count
FROM CTE_FN;
