BEGIN 
    pkg_etl_clients_dw.load_CLEAN_CLIENTS_DW;
    pkg_etl_restaurants_dw.load_CLEAN_RESTAURANTS_DW;
    pkg_etl_employees_dw.load_CLEAN_EMPLOYEES_DW;
    pkg_etl_dishes_dw.load_CLEAN_DISHES_DW;
    pkg_etl_payment_methods_dw.load_CLEAN_PAYMENT_METHODS_DW;
    pkg_etl_gen_periods_dw.load_CLEAN_GEN_PERIODS_DW;
--    pkg_etl_transactions_dw.load_CLEAN_TRANSACTIONS_DW;
--    pkg_etl_payment_methods_dw.load_CLEAN_PAYMENT_METHODS_DW_with_to_refcursor_func;
    pkg_etl_payment_methods_dw.load_CLEAN_PAYMENT_METHODS_DW_with_to_cursor_number_func;
END;

SELECT * FROM  dw_data.client_dimension;
--truncate table dw_data.client_dimension;
SELECT * FROM dw_data.restaurant_dimension;
--truncate table dw_data.restaurant_dimension;
SELECT * FROM dw_data.employee_dimension;
--truncate table dw_data.employee_dimension;
SELECT * FROM dw_data.dish_dimension;
--truncate table dw_data.dish_dimension;
SELECT * FROM dw_data.payment_method_dimension;
--truncate table dw_data.payment_method_dimension;
SELECT * FROM dw_data.dim_gen_period;
--truncate table dw_data.dim_gen_period;
SELECT * FROM dw_data.order_fact
ORDER BY 1;
--truncate table dw_data.order_fact;

