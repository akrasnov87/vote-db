CREATE OR REPLACE FUNCTION core.pf_stores() RETURNS TABLE(table_name text, table_type text, table_title text, primary_key text, table_comment text)
    LANGUAGE plpgsql
    AS $$
DECLARE
	_current_database text;
BEGIN
	SELECT (current_database())::text
	INTO _current_database;
 RETURN QUERY select 
				t.table_name::text, 
				t.table_type::text, 
				pgd.description::text as TABLE_TITLE,
				cc.column_name::text as PRIMARY_KEY,
				''::text as TABLE_COMMENT
			from information_schema.tables as t
			left join pg_catalog.pg_statio_all_tables as st ON st.relname = t.table_name
			left join pg_catalog.pg_description pgd on pgd.objoid = st.relid and pgd.objsubid = 0
			left join information_schema.table_constraints tc ON t.table_name = tc.table_name and t.table_catalog = tc.table_catalog
			left join information_schema.constraint_column_usage cc ON tc.constraint_name = cc.constraint_name
			where t.table_catalog = _current_database AND tc.constraint_type = 'PRIMARY KEY' 
			UNION 
			select 
				t.table_name::text, 
				t.table_type::text, 
				pgd.description::text as TABLE_TITLE,
				''::text as PRIMARY_KEY,
				''::text as TABLE_COMMENT
			from information_schema.tables as t 
			left join pg_catalog.pg_class as pgc ON pgc.relname = t.table_name
			left join pg_catalog.pg_description pgd on pgd.objoid = pgc.oid
			where t.table_type = 'VIEW' AND t.table_catalog = _current_database and (t.table_schema = 'core' or t.table_schema = 'core')
			UNION 
			select 
				ROUTINE_NAME::text AS TABLE_NAME, 
				ROUTINE_TYPE::text AS TABLE_TYPE, 
				''::text AS TABLE_TITLE,
				''::text as PRIMARY_KEY,
				''::text as TABLE_COMMENT
			from information_schema.ROUTINES 
			where routine_catalog = _current_database and (routine_schema = 'core' or routine_schema = 'core');
END; $$;

ALTER FUNCTION core.pf_stores() OWNER TO mobnius;

COMMENT ON FUNCTION core.pf_stores() IS 'Получение списка хранилищ';
