WITH CTE_FN AS
( SELECT dish_name,
TRUNC(order_date, 'YYYY') AS year,
TO_CHAR(order_date, 'MM') AS month,
'MONTH' period,
COUNT(*) AS dish_count
FROM sa_orders.sa_t_transaction
GROUP BY dish_name, TRUNC(order_date, 'YYYY'),TO_CHAR(order_date, 'MM')
ORDER BY dish_name, year, month)
SELECT dish_name, year, month, period, dish_count
FROM CTE_FN
MODEL
PARTITION BY (dish_name)
DIMENSION BY (year, month, period)
MEASURES(dish_count)
RULES (
    dish_count[FOR year IN (SELECT DISTINCT year FROM CTE_FN), 
    NULL, 'YEAR']=SUM(dish_count)[cv(year), ANY, 'MONTH'],
    dish_count [NULL, NULL, 'ALL']=SUM(dish_count)[ANY, NULL,'YEAR']
    )
ORDER BY dish_name, year, month;