CREATE FOREIGN TABLE imp.cd_mobile_help (
	id uuid NOT NULL,
	c_key text NOT NULL,
	c_html text,
	d_date timestamp with time zone,
	c_title text NOT NULL,
	b_disabled boolean NOT NULL,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cd_mobile_help');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN c_key OPTIONS (column_name 'c_key');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN c_html OPTIONS (column_name 'c_html');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN c_title OPTIONS (column_name 'c_title');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cd_mobile_help ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_mobile_help OWNER TO postgres;
