--drop view u_dw_references.w_lng_links;

--==============================================================
-- View: w_lng_links                                            
--==============================================================
create or replace view u_dw_references.w_lng_links as
select
   parent_lng_id,
   child_lng_id,
   link_type_id
from
   t_lng_links;

comment on column u_dw_references.w_lng_links.parent_lng_id is
'Link: Paranet Object - Languages T_LANGUAGES';

comment on column u_dw_references.w_lng_links.child_lng_id is
'Link: Child Object - Languages T_LANGUAGES';

comment on column u_dw_references.w_lng_links.link_type_id is
'Link Type: 1 - Macrolanguages to Individual Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_lng_links to u_dw_ext_references;

SELECT * FROM u_dw_references.w_lng_links;

SELECT * FROM all_tables WHERE OWNER = UPPER('u_dw_references');

select * from all_objects where owner = UPPER('U_DW_REFERENCES')
order by OBJECT_TYPE, OBJECT_NAME;


SELECT Table_Name, OWNER
FROM SYS.ALL_TABLES
WHERE OWNER IN ('U_DW_REFERENCES', 'U_DW_EXT_REFERENCES', 'U_DW_COMMON')
UNION
SELECT View_Name, OWNER
FROM SYS.ALL_VIEWS
WHERE OWNER IN ('U_DW_REFERENCES', 'U_DW_EXT_REFERENCES', 'U_DW_COMMON')
ORDER BY 1;