alter session set current_schema = sa_restaurants;
GRANT SELECT ON sa_t_employee  TO DW_CL;
alter session set current_schema = DW_CL;
select * from sa_restaurants.sa_t_employee;

CREATE OR REPLACE PACKAGE body pkg_etl_employees_cl
AS  
  PROCEDURE load_CLEAN_EMPLOYEES
   AS
      CURSOR c_v IS
         SELECT DISTINCT first_name
                       , last_name
                       , phone
                       , email
                       , department
                       , job_title
                       , street
                       , country
                       , city
                       , building
                       , apartment
                       , employee_status
           FROM sa_restaurants.sa_t_employee
           WHERE first_name IS NOT NULL 
           AND last_name IS NOT NULL
           AND phone IS NOT NULL
           AND email IS NOT NULL
           AND department IS NOT NULL
           AND job_title IS NOT NULL
           AND street IS NOT NULL
           AND country IS NOT NULL
           AND city IS NOT NULL
           AND building IS NOT NULL
           AND apartment IS NOT NULL
           AND employee_status IS NOT NULL;
   BEGIN
       EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_employee';
      FOR i IN c_v LOOP
         INSERT INTO dw_cl.cl_t_employee( 
                      first_name
                       , last_name
                       , phone
                       , email
                       , department
                       , job_title
                       , street
                       , country
                       , city
                       , building
                       , apartment
                       , employee_status)
              VALUES ( i.first_name
                       , i.last_name
                       , i.phone
                       , i.email
                       , i.department
                       , i.job_title
                       , i.street
                       , i.country
                       , i.city
                       , i.building
                       , i.apartment
                       , i.employee_status);
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_EMPLOYEES;
END pkg_etl_employees_cl;
