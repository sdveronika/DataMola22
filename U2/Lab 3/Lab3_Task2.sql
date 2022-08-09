SELECT /*+inline gather_plan_statistics */
    level   
    ,   lpad(' ', 2*(level-1)) || job_title  job_title
    ,   first_name || '  ' || last_name as employee_name
    ,   CONNECT_BY_ROOT job_title AS root
    ,   SYS_CONNECT_BY_PATH(job_title, ':') path
FROM sa_restaurants.sa_t_employee 
WHERE CONNECT_BY_ROOT job_title='director'
CONNECT BY NOCYCLE PRIOR job_title_child_id=job_title_parent_id
START WITH job_title_parent_id IS NULL;
