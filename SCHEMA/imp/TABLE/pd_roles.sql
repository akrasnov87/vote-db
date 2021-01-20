CREATE FOREIGN TABLE imp.pd_roles (
	id integer NOT NULL,
	c_name text NOT NULL,
	c_description text,
	n_weight integer NOT NULL,
	sn_delete boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'pd_roles');

ALTER FOREIGN TABLE imp.pd_roles ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.pd_roles ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE imp.pd_roles ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.pd_roles ALTER COLUMN n_weight OPTIONS (column_name 'n_weight');

ALTER FOREIGN TABLE imp.pd_roles ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.pd_roles OWNER TO postgres;
