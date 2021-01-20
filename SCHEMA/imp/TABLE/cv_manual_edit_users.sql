CREATE FOREIGN TABLE imp.cv_manual_edit_users (
	id integer,
	c_login text,
	c_password text,
	dx_created timestamp with time zone,
	b_disabled boolean
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_manual_edit_users');

ALTER FOREIGN TABLE imp.cv_manual_edit_users ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cv_manual_edit_users ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.cv_manual_edit_users ALTER COLUMN c_password OPTIONS (column_name 'c_password');

ALTER FOREIGN TABLE imp.cv_manual_edit_users ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cv_manual_edit_users ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cv_manual_edit_users OWNER TO postgres;
