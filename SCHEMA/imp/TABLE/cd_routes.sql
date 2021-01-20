CREATE FOREIGN TABLE imp.cd_routes (
	id uuid NOT NULL,
	f_type integer NOT NULL,
	c_number text NOT NULL,
	d_date timestamp with time zone NOT NULL,
	d_date_start date NOT NULL,
	d_date_end date NOT NULL,
	c_notice text,
	b_extended boolean NOT NULL,
	d_extended date,
	jb_data jsonb,
	dx_created timestamp with time zone NOT NULL,
	n_order integer NOT NULL,
	f_house uuid
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_routes');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN f_type OPTIONS (column_name 'f_type');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN c_number OPTIONS (column_name 'c_number');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN d_date_start OPTIONS (column_name 'd_date_start');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN d_date_end OPTIONS (column_name 'd_date_end');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN b_extended OPTIONS (column_name 'b_extended');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN d_extended OPTIONS (column_name 'd_extended');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cd_routes ALTER COLUMN f_house OPTIONS (column_name 'f_house');

ALTER FOREIGN TABLE imp.cd_routes OWNER TO postgres;
