CREATE FOREIGN TABLE imp.cv_routes (
	f_route uuid,
	f_user integer,
	c_login text,
	f_type integer,
	c_type text,
	c_number text,
	d_date_start date,
	d_date_end date,
	c_status text
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_routes');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN f_route OPTIONS (column_name 'f_route');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN f_type OPTIONS (column_name 'f_type');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN c_type OPTIONS (column_name 'c_type');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN c_number OPTIONS (column_name 'c_number');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN d_date_start OPTIONS (column_name 'd_date_start');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN d_date_end OPTIONS (column_name 'd_date_end');

ALTER FOREIGN TABLE imp.cv_routes ALTER COLUMN c_status OPTIONS (column_name 'c_status');

ALTER FOREIGN TABLE imp.cv_routes OWNER TO postgres;
