CREATE FOREIGN TABLE imp.cv_uik (
	n_uik integer
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_uik');

ALTER FOREIGN TABLE imp.cv_uik ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_uik OWNER TO postgres;
