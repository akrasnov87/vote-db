CREATE FOREIGN TABLE imp.sv_objects (
	table_name character varying,
	table_type character varying,
	table_title character varying,
	primary_key character varying,
	table_comment character varying,
	table_schema information_schema.sql_identifier,
	table_catalog information_schema.sql_identifier
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'sv_objects');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN table_name OPTIONS (column_name 'table_name');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN table_type OPTIONS (column_name 'table_type');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN table_title OPTIONS (column_name 'table_title');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN primary_key OPTIONS (column_name 'primary_key');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN table_comment OPTIONS (column_name 'table_comment');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN table_schema OPTIONS (column_name 'table_schema');

ALTER FOREIGN TABLE imp.sv_objects ALTER COLUMN table_catalog OPTIONS (column_name 'table_catalog');

ALTER FOREIGN TABLE imp.sv_objects OWNER TO postgres;
