CREATE FOREIGN TABLE imp.cd_action_log (
	id uuid NOT NULL,
	c_table_name text,
	c_operation text,
	jb_old_value jsonb,
	jb_new_value jsonb,
	c_user text,
	d_date timestamp with time zone
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_action_log');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN c_table_name OPTIONS (column_name 'c_table_name');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN c_operation OPTIONS (column_name 'c_operation');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN jb_old_value OPTIONS (column_name 'jb_old_value');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN jb_new_value OPTIONS (column_name 'jb_new_value');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN c_user OPTIONS (column_name 'c_user');

ALTER FOREIGN TABLE imp.cd_action_log ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_action_log OWNER TO postgres;
