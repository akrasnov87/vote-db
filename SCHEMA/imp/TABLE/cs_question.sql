CREATE FOREIGN TABLE imp.cs_question (
	id bigint NOT NULL,
	c_title text NOT NULL,
	c_description text NOT NULL,
	c_text text NOT NULL,
	n_order integer NOT NULL,
	b_disabled boolean NOT NULL,
	dx_created timestamp with time zone NOT NULL,
	sn_delete boolean NOT NULL,
	f_role integer,
	n_priority integer
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cs_question');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN c_title OPTIONS (column_name 'c_title');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN c_text OPTIONS (column_name 'c_text');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN f_role OPTIONS (column_name 'f_role');

ALTER FOREIGN TABLE imp.cs_question ALTER COLUMN n_priority OPTIONS (column_name 'n_priority');

ALTER FOREIGN TABLE imp.cs_question OWNER TO postgres;
