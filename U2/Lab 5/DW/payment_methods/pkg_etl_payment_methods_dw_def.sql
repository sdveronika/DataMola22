CREATE OR REPLACE PACKAGE pkg_etl_payment_methods_dw
AS  
   PROCEDURE load_CLEAN_PAYMENT_METHODS_DW;
   PROCEDURE load_CLEAN_PAYMENT_METHODS_DW_with_to_cursor_number_func;
   PROCEDURE load_CLEAN_PAYMENT_METHODS_DW_with_to_refcursor_func;
END pkg_etl_payment_methods_dw;