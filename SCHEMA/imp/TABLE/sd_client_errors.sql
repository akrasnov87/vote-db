CREATE FOREIGN TABLE imp.sd_client_errors (
	id uuid NOT NULL,
	c_message text NOT NULL,
	c_code text NOT NULL,
	d_created timestamp with time zone NOT NULL,
	fn_user integer NOT NULL,
	c_version text NOT NULL,
	c_platform text NOT NULL,
	jb_data jsonb,
	dx_date timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'sd_client_errors');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN c_message OPTIONS (column_name 'c_message');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN c_code OPTIONS (column_name 'c_code');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN d_created OPTIONS (column_name 'd_created');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN c_version OPTIONS (column_name 'c_version');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN c_platform OPTIONS (column_name 'c_platform');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.sd_client_errors ALTER COLUMN dx_date OPTIONS (column_name 'dx_date');

ALTER FOREIGN TABLE imp.sd_client_errors OWNER TO postgres;
