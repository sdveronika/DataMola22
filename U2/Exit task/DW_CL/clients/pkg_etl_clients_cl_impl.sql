alter session set current_schema = SA_CLIENTS;
GRANT SELECT ON sa_t_client  TO DW_CL;
alter session set current_schema = DW_CL;
select * from SA_CLIENTS.sa_t_client;

CREATE OR REPLACE PACKAGE body pkg_etl_clients_cl
AS  
  PROCEDURE load_CLEAN_CLIENTS
   AS
      CURSOR c_v IS
         SELECT DISTINCT first_name
                       , last_name
                       , phone
                       , email
                       , street
                       , country
                       , city
                       , client_status
           FROM sa_clients.sa_t_client
           WHERE first_name IS NOT NULL 
           AND last_name IS NOT NULL
           AND phone IS NOT NULL
           AND email IS NOT NULL
           AND street IS NOT NULL
           AND country IS NOT NULL
           AND city IS NOT NULL
           AND client_status IS NOT NULL;
   BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_client';
      FOR i IN c_v LOOP
         INSERT INTO dw_cl.cl_t_client( 
                       first_name
                       , last_name
                       , phone
                       , email
                       , street
                       , country
                       , city
                       , client_status)
              VALUES ( i.first_name
                       , i.last_name
                       , i.phone
                       , i.email
                       , i.street
                       , i.country
                       , i.city
                       , i.client_status);
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_CLIENTS;
END pkg_etl_clients_cl;
