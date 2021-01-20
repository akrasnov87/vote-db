CREATE FOREIGN TABLE imp.cd_points (
	id uuid NOT NULL,
	f_appartament uuid NOT NULL,
	f_route uuid NOT NULL,
	c_notice text,
	c_info text,
	jb_data jsonb,
	dx_created timestamp with time zone NOT NULL,
	n_order integer NOT NULL,
	n_priority integer
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_points');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN f_appartament OPTIONS (column_name 'f_appartament');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN f_route OPTIONS (column_name 'f_route');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN c_info OPTIONS (column_name 'c_info');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cd_points ALTER COLUMN n_priority OPTIONS (column_name 'n_priority');

ALTER FOREIGN TABLE imp.cd_points OWNER TO postgres;
