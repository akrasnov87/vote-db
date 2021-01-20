CREATE FOREIGN TABLE imp.pv_users (
	id integer,
	f_parent integer,
	c_login text,
	c_claims text,
	c_email text,
	c_tel text,
	c_description text,
	n_uik integer,
	c_fio text,
	f_subdivision integer,
	f_division integer,
	f_subdivision_f_division integer,
	c_subdivision text,
	c_all_divisions text,
	c_divisions text,
	c_subdivisions text,
	b_disabled boolean
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'pv_users');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN f_parent OPTIONS (column_name 'f_parent');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_claims OPTIONS (column_name 'c_claims');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_email OPTIONS (column_name 'c_email');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_tel OPTIONS (column_name 'c_tel');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_fio OPTIONS (column_name 'c_fio');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN f_subdivision_f_division OPTIONS (column_name 'f_subdivision_f_division');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_subdivision OPTIONS (column_name 'c_subdivision');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_all_divisions OPTIONS (column_name 'c_all_divisions');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_divisions OPTIONS (column_name 'c_divisions');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN c_subdivisions OPTIONS (column_name 'c_subdivisions');

ALTER FOREIGN TABLE imp.pv_users ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.pv_users OWNER TO postgres;
