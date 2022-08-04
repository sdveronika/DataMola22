WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'DD' ) AS order_date, country_r, city_r, SUM(total_cost) AS profit
FROM sa_orders.sa_t_transaction 
GROUP BY CUBE(order_date, country_r,  city_r)
HAVING TRUNC ( order_date, 'DD' ) IS NOT NULL AND country_r IS NOT NULL AND city_r IS NOT NULL
ORDER BY 1)
SELECT order_date, country_r, city_r, profit FROM CTE_FN;

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'DD' ) AS order_date,
country_r, city_r, COUNT(email_c)  AS visit_amount
FROM sa_orders.sa_t_transaction 
WHERE delivery = 'N'
GROUP BY CUBE(TRUNC ( order_date, 'DD' ), country_r, city_r)
HAVING TRUNC ( order_date, 'DD' ) IS NOT NULL AND country_r IS NOT NULL AND city_r IS NOT NULL 
ORDER BY 1, 2, 4)
SELECT order_date, country_r, city_r, visit_amount FROM CTE_FN;

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'DD' ) AS order_date,
country_r, city_r,dish_name, COUNT(dish_name)  AS dish_count
FROM sa_orders.sa_t_transaction 
GROUP BY CUBE(TRUNC ( order_date, 'DD' ), country_r, city_r,dish_name)
HAVING TRUNC ( order_date, 'DD' ) IS NOT NULL AND country_r IS NOT NULL AND city_r IS NOT NULL AND dish_name IS NOT NULL
ORDER BY 1,2,4,5)
SELECT order_date, country_r, city_r, dish_name,dish_count FROM CTE_FN;

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'DD' ) AS order_date,
country_r, city_r,dish_category, COUNT(dish_name)  AS dish_count
FROM sa_orders.sa_t_transaction 
GROUP BY CUBE(TRUNC ( order_date, 'DD' ), country_r, city_r,dish_category)
HAVING TRUNC ( order_date, 'DD' ) IS NOT NULL AND country_r IS NOT NULL AND city_r IS NOT NULL AND dish_category IS NOT NULL
ORDER BY 1,2,4,5)
SELECT order_date, country_r, city_r, dish_category,dish_count FROM CTE_FN;

WITH CTE_FN AS (
SELECT  /*+ gather_plan_statistics */ TRUNC ( order_date, 'DD' ) AS order_date, country_r, 
city_r, AVG(total_cost) AS avd_chek
FROM sa_orders.sa_t_transaction 
GROUP BY CUBE(order_date, country_r,  city_r)
HAVING TRUNC ( order_date, 'DD' ) IS NOT NULL AND country_r IS NOT NULL AND city_r IS NOT NULL
ORDER BY 1)
SELECT order_date, country_r, city_r, avd_chek FROM CTE_FN;




