SELECT * FROM dw_cl.cl_t_dish;
UPDATE dw_cl.cl_t_dish
SET price=15 
WHERE dish_name='soup';

SELECT dish_name, dish_category, price, rank() OVER ( ORDER BY price ASC) price_rank
FROM dw_cl.cl_t_dish
ORDER BY price_rank;

SELECT dish_name, dish_category, price, DENSE_rank() OVER ( ORDER BY price ASC) price_rank
FROM dw_cl.cl_t_dish
ORDER BY price_rank;

SELECT dish_name, dish_category, price,
       DENSE_rank() OVER ( ORDER BY price ASC) price_rank,
       ROW_NUMBER() OVER (ORDER BY price ASC) price_row_number
FROM dw_cl.cl_t_dish
ORDER BY price_rank;

