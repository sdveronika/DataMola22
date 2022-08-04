WITH CTE_FN AS(
SELECT /*+ gather_plan_statistics */ TRUNC ( order_date, 'MM' ) AS order_date, 
    DECODE (GROUPING(country_r), 1, 'All countries', country_r) AS country_r,
    DECODE (GROUPING(city_r), 1, 'All cities', city_r) AS city_r,
    SUM(total_cost) AS profit
FROM sa_orders.sa_t_transaction
GROUP BY TRUNC ( order_date, 'MM' ),CUBE(  country_r, city_r)
HAVING  GROUPING_ID (country_r)<1 
ORDER BY 1, 2, 3, 4)
SELECT order_date, country_r, city_r, profit
FROM CTE_FN;

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'MM' ) AS order_date,
    DECODE (GROUPING(country_r), 1, 'All countries', country_r) AS country_r,
    DECODE (GROUPING(city_r), 1, 'All cities', city_r) AS city_r,
    COUNT(email_c)  AS visit_amount
FROM sa_orders.sa_t_transaction 
WHERE delivery = 'N'
GROUP BY TRUNC ( order_date, 'MM' ),CUBE( country_r, city_r)
HAVING  GROUPING_ID (country_r)<1
ORDER BY 1, 2, 3, 4)
SELECT order_date, country_r, city_r, visit_amount 
FROM CTE_FN;

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

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'MM' ) AS order_date,
    DECODE (GROUPING(country_r), 1, 'All countries', country_r) AS country_r,
    DECODE (GROUPING(city_r), 1, 'All cities', city_r) AS city_r,
    DECODE (GROUPING(dish_category), 1, 'All categories', dish_category) AS dish_category,
    COUNT(dish_name) AS dish_count
FROM sa_orders.sa_t_transaction 
GROUP BY TRUNC ( order_date, 'MM' ), ROLLUP( country_r, city_r,dish_category)
ORDER BY 1,2,4,5)
SELECT order_date, country_r, city_r, dish_category,dish_count FROM CTE_FN;

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'DD' ) AS order_date, 
    DECODE (GROUPING(country_r), 1, 'All countries', country_r) AS country_r,
    DECODE (GROUPING(city_r), 1, 'All cities', city_r) AS city_r,
    AVG(total_cost) AS avd_chek
FROM sa_orders.sa_t_transaction 
GROUP BY TRUNC ( order_date, 'DD' ), 
    GROUPING SETS ((order_date), (country_r),(city_r),(order_date, country_r,city_r ))
HAVING  GROUPING_ID (country_r)<1 
ORDER BY 1,2,3,4)
SELECT order_date, country_r, city_r, avd_chek FROM CTE_FN;


