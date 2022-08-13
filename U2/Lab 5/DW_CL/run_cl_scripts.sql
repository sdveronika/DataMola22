BEGIN
    pkg_etl_clients_cl.load_CLEAN_CLIENTS;
    pkg_etl_dishes_cl.load_CLEAN_DISHES;
    pkg_etl_employees_cl.load_CLEAN_EMPLOYEES;
    pkg_etl_gen_priods_cl.load_CLEAN_GEN_PERIODS;
    pkg_etl_payment_methods_cl.load_CLEAN_PAYMENT_METHODS;
    pkg_etl_restaurants_cl.load_CLEAN_RESTAURANTS;
    pkg_etl_transactions_cl.load_CLEAN_TRANSACTIONS;
END;


SELECT * FROM dw_cl.cl_t_client;
SELECT * FROM dw_cl.cl_t_dish;
SELECT * FROM dw_cl.cl_t_employee;
SELECT * FROM dw_cl.cl_t_gen_period;
SELECT * FROM dw_cl.cl_t_payment_method;
SELECT * FROM dw_cl.cl_t_restaurant;
SELECT * FROM dw_cl.cl_t_transaction;
