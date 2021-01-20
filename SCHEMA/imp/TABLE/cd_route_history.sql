CREATE FOREIGN TABLE imp.cd_route_history (
	id uuid NOT NULL,
	fn_route uuid NOT NULL,
	fn_status integer NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_notice text,
	dx_created timestamp with time zone
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_route_history');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN fn_route OPTIONS (column_name 'fn_route');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN fn_status OPTIONS (column_name 'fn_status');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE imp.cd_route_history ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_route_history OWNER TO postgres;
