CREATE FOREIGN TABLE imp.sv_users (
	id integer,
	f_parent integer,
	c_login text,
	c_password text,
	s_salt text,
	s_hash text,
	c_claims text,
	c_all_divisions text,
	b_disabled boolean
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'sv_users');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN f_parent OPTIONS (column_name 'f_parent');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN c_password OPTIONS (column_name 'c_password');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN s_salt OPTIONS (column_name 's_salt');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN s_hash OPTIONS (column_name 's_hash');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN c_claims OPTIONS (column_name 'c_claims');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN c_all_divisions OPTIONS (column_name 'c_all_divisions');

ALTER FOREIGN TABLE imp.sv_users ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.sv_users OWNER TO postgres;
