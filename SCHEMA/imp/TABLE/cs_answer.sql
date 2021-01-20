CREATE FOREIGN TABLE imp.cs_answer (
	id bigint NOT NULL,
	c_text text,
	f_question integer NOT NULL,
	f_next_question integer,
	c_action text,
	n_order integer NOT NULL,
	b_disabled boolean NOT NULL,
	dx_created timestamp with time zone NOT NULL,
	sn_delete boolean NOT NULL,
	c_color text,
	f_role integer
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cs_answer');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN c_text OPTIONS (column_name 'c_text');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN f_question OPTIONS (column_name 'f_question');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN f_next_question OPTIONS (column_name 'f_next_question');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN c_action OPTIONS (column_name 'c_action');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN c_color OPTIONS (column_name 'c_color');

ALTER FOREIGN TABLE imp.cs_answer ALTER COLUMN f_role OPTIONS (column_name 'f_role');

ALTER FOREIGN TABLE imp.cs_answer OWNER TO postgres;
