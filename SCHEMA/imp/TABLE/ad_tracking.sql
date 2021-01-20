CREATE FOREIGN TABLE imp.ad_tracking (
	id uuid NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_network_status text,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'ad_tracking');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN n_longitude OPTIONS (column_name 'n_longitude');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN n_latitude OPTIONS (column_name 'n_latitude');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN c_network_status OPTIONS (column_name 'c_network_status');

ALTER FOREIGN TABLE imp.ad_tracking ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.ad_tracking OWNER TO postgres;
