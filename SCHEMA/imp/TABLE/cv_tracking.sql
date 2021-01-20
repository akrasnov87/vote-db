CREATE FOREIGN TABLE imp.cv_tracking (
	f_user integer,
	d_date_str text,
	d_date timestamp with time zone,
	n_longitude numeric,
	n_latitude numeric,
	c_network_status text
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_tracking');

ALTER FOREIGN TABLE imp.cv_tracking ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cv_tracking ALTER COLUMN d_date_str OPTIONS (column_name 'd_date_str');

ALTER FOREIGN TABLE imp.cv_tracking ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cv_tracking ALTER COLUMN n_longitude OPTIONS (column_name 'n_longitude');

ALTER FOREIGN TABLE imp.cv_tracking ALTER COLUMN n_latitude OPTIONS (column_name 'n_latitude');

ALTER FOREIGN TABLE imp.cv_tracking ALTER COLUMN c_network_status OPTIONS (column_name 'c_network_status');

ALTER FOREIGN TABLE imp.cv_tracking OWNER TO postgres;
