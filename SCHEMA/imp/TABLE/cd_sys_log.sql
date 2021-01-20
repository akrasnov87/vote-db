CREATE FOREIGN TABLE imp.cd_sys_log (
	id uuid NOT NULL,
	n_level_msg integer,
	d_timestamp timestamp with time zone,
	c_descr text
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_sys_log');

ALTER FOREIGN TABLE imp.cd_sys_log ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_sys_log ALTER COLUMN n_level_msg OPTIONS (column_name 'n_level_msg');

ALTER FOREIGN TABLE imp.cd_sys_log ALTER COLUMN d_timestamp OPTIONS (column_name 'd_timestamp');

ALTER FOREIGN TABLE imp.cd_sys_log ALTER COLUMN c_descr OPTIONS (column_name 'c_descr');

ALTER FOREIGN TABLE imp.cd_sys_log OWNER TO postgres;
