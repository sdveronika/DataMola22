SELECT order_date, country_r,
       FIRST_VALUE(PROFIT) OVER (PARTITION BY order_date, country_r ORDER BY profit DESC 
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_profit_in_the_country_in_a_month
FROM(
SELECT TRUNC(order_date,'MM') AS order_date, country_r, SUM(price) AS profit
FROM dw_cl.cl_t_transaction
GROUP BY TRUNC(order_date,'MM'),country_r)
WHERE country_r IN (SELECT DISTINCT country_r FROM dw_cl.cl_t_transaction)
ORDER BY 1;

SELECT order_date, country_r,
       LAST_VALUE(PROFIT) OVER (PARTITION BY order_date, country_r ORDER BY profit DESC 
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_profit_in_the_country_in_a_month
FROM(
SELECT TRUNC(order_date,'MM') AS order_date, country_r, SUM(price) AS profit
FROM dw_cl.cl_t_transaction
GROUP BY TRUNC(order_date,'MM'),country_r)
WHERE country_r IN (SELECT DISTINCT country_r FROM dw_cl.cl_t_transaction)
ORDER BY 1;