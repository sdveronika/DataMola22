SELECT TRUNC(order_date, 'MM') as order_date, country_r, city_r, MAX(total_cost) AS max_total_cost
FROM dw_cl.cl_t_transaction
GROUP BY TRUNC(order_date, 'MM'), country_r, city_r
ORDER BY 1, 2;

SELECT TRUNC(order_date, 'MM') as order_date, country_r, city_r, MIN(total_cost) AS min_total_cost
FROM dw_cl.cl_t_transaction
GROUP BY TRUNC(order_date, 'MM'), country_r, city_r
ORDER BY 1, 2;

SELECT TRUNC(order_date, 'MM') as order_date, country_r, city_r, AVG(total_cost) AS avg_total_cost
FROM dw_cl.cl_t_transaction
GROUP BY TRUNC(order_date, 'MM'), country_r, city_r
ORDER BY 1, 2;

