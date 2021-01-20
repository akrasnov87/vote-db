CREATE FOREIGN TABLE imp.cd_results (
	id uuid NOT NULL,
	fn_user_point uuid NOT NULL,
	fn_point uuid NOT NULL,
	fn_type integer NOT NULL,
	fn_user integer NOT NULL,
	fn_route uuid NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_notice text,
	b_warning boolean NOT NULL,
	fn_question integer,
	fn_answer integer,
	jb_data jsonb,
	dx_created timestamp with time zone NOT NULL,
	n_order integer NOT NULL,
	n_rating integer,
	b_disabled boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_results');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_user_point OPTIONS (column_name 'fn_user_point');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_point OPTIONS (column_name 'fn_point');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_type OPTIONS (column_name 'fn_type');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_route OPTIONS (column_name 'fn_route');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN b_warning OPTIONS (column_name 'b_warning');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_question OPTIONS (column_name 'fn_question');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN fn_answer OPTIONS (column_name 'fn_answer');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN n_rating OPTIONS (column_name 'n_rating');

ALTER FOREIGN TABLE imp.cd_results ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cd_results OWNER TO postgres;
