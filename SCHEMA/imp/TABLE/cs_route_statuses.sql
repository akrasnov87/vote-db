CREATE FOREIGN TABLE imp.cs_route_statuses (
	id integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer,
	b_disabled boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cs_route_statuses');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN n_code OPTIONS (column_name 'n_code');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN c_short_name OPTIONS (column_name 'c_short_name');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN c_const OPTIONS (column_name 'c_const');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cs_route_statuses ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cs_route_statuses OWNER TO postgres;
