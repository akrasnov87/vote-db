CREATE FOREIGN TABLE imp.cv_street_types (
	c_type text,
	c_short_type text
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_street_types');

ALTER FOREIGN TABLE imp.cv_street_types ALTER COLUMN c_type OPTIONS (column_name 'c_type');

ALTER FOREIGN TABLE imp.cv_street_types ALTER COLUMN c_short_type OPTIONS (column_name 'c_short_type');

ALTER FOREIGN TABLE imp.cv_street_types OWNER TO postgres;
