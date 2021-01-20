CREATE FOREIGN TABLE imp.cd_settings (
	id integer NOT NULL,
	c_key text NOT NULL,
	c_value text,
	f_type integer NOT NULL,
	c_label text,
	c_summary text,
	f_division integer,
	f_user integer,
	sn_delete boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_settings');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN c_key OPTIONS (column_name 'c_key');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN c_value OPTIONS (column_name 'c_value');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN f_type OPTIONS (column_name 'f_type');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN c_label OPTIONS (column_name 'c_label');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN c_summary OPTIONS (column_name 'c_summary');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cd_settings ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.cd_settings OWNER TO postgres;
