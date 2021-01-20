CREATE FOREIGN TABLE imp.cd_feedbacks (
	id uuid NOT NULL,
	c_imei text NOT NULL,
	fn_user integer NOT NULL,
	fn_type integer NOT NULL,
	c_question text NOT NULL,
	d_date_question timestamp with time zone NOT NULL,
	c_answer text,
	d_date_answer timestamp with time zone,
	dx_created timestamp with time zone NOT NULL,
	jb_data jsonb
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_feedbacks');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN c_imei OPTIONS (column_name 'c_imei');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN fn_type OPTIONS (column_name 'fn_type');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN c_question OPTIONS (column_name 'c_question');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN d_date_question OPTIONS (column_name 'd_date_question');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN c_answer OPTIONS (column_name 'c_answer');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN d_date_answer OPTIONS (column_name 'd_date_answer');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_feedbacks ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.cd_feedbacks OWNER TO postgres;
