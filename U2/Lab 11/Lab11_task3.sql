WITH CTE_FN AS (
SELECT /*+ gather_plan_statistics */ 
    dish_name,
    DECODE (GROUPING (TRUNC(order_date, 'YYYY')),1,'All years',TRUNC(order_date, 'YYYY'))  AS year_ord,
    DECODE (GROUPING (TRUNC(order_date, 'MM')),1,'All months',TRUNC(order_date, 'MM'))  AS month_ord,
    COUNT(*) AS dish_count
    FROM sa_orders.sa_t_transaction 
    GROUP BY  GROUPING SETS ((dish_name),
    (dish_name, TRUNC(order_date, 'YYYY')),
    (dish_name,TRUNC(order_date, 'YYYY'),TRUNC(order_date, 'MM')))
    ORDER BY 1,2,3,4)
SELECT dish_name,year_ord, month_ord, dish_count FROM CTE_FN;

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

WITH CTE_FN AS (
SELECT /*+ gather_plan_statistics */ 
    dish_name,
    DECODE (GROUPING (TRUNC(date_id, 'YYYY')),1,'All years',TRUNC(date_id, 'YYYY'))  AS year_ord,
    DECODE (GROUPING (TRUNC(date_id, 'MM')),1,'All months',TRUNC(date_id, 'MM'))  AS month_ord,
    COUNT(*) AS dish_count
    FROM dw_data.order_fact fct
        LEFT JOIN dw_data.dish_dimension dsh
        ON(fct.dish_id=dsh.dish_id)
    GROUP BY  GROUPING SETS ((dish_name),
    (dish_name, TRUNC(date_id, 'YYYY')),
    (dish_name,TRUNC(date_id, 'YYYY'),TRUNC(date_id, 'MM')))
    ORDER BY 1,2,3,4)
SELECT dish_name,year_ord, month_ord, dish_count FROM CTE_FN;