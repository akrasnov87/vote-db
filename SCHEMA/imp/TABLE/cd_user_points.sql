CREATE FOREIGN TABLE imp.cd_user_points (
	id uuid NOT NULL,
	fn_point uuid,
	fn_user integer NOT NULL,
	fn_route uuid NOT NULL,
	fn_type integer NOT NULL,
	jb_tel jsonb,
	jb_email jsonb,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_notice text,
	b_check boolean NOT NULL,
	jb_data jsonb,
	d_date_check timestamp with time zone,
	dx_created timestamp with time zone NOT NULL,
	d_date timestamp with time zone NOT NULL,
	b_disabled boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_user_points');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN fn_point OPTIONS (column_name 'fn_point');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN fn_route OPTIONS (column_name 'fn_route');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN fn_type OPTIONS (column_name 'fn_type');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN jb_tel OPTIONS (column_name 'jb_tel');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN jb_email OPTIONS (column_name 'jb_email');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN n_longitude OPTIONS (column_name 'n_longitude');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN n_latitude OPTIONS (column_name 'n_latitude');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN b_check OPTIONS (column_name 'b_check');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN d_date_check OPTIONS (column_name 'd_date_check');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_user_points ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cd_user_points OWNER TO postgres;
