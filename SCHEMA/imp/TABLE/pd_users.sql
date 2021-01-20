CREATE FOREIGN TABLE imp.pd_users (
	id integer NOT NULL,
	f_parent integer,
	c_login text NOT NULL,
	c_password text,
	s_salt text,
	s_hash text,
	c_email text,
	c_tel text,
	c_imei text,
	c_description text,
	b_disabled boolean NOT NULL,
	sn_delete boolean NOT NULL,
	n_uik integer,
	dx_created timestamp with time zone NOT NULL,
	f_subdivision integer,
	c_fio text,
	f_division integer
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'pd_users');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN f_parent OPTIONS (column_name 'f_parent');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_password OPTIONS (column_name 'c_password');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN s_salt OPTIONS (column_name 's_salt');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN s_hash OPTIONS (column_name 's_hash');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_email OPTIONS (column_name 'c_email');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_tel OPTIONS (column_name 'c_tel');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_imei OPTIONS (column_name 'c_imei');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN c_fio OPTIONS (column_name 'c_fio');

ALTER FOREIGN TABLE imp.pd_users ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.pd_users OWNER TO postgres;
