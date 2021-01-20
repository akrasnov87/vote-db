CREATE FOREIGN TABLE imp.pd_accesses (
	id integer NOT NULL,
	f_user integer,
	f_role integer,
	c_name text,
	c_criteria text,
	c_path text,
	c_function text,
	c_columns text,
	b_deletable boolean NOT NULL,
	b_creatable boolean NOT NULL,
	b_editable boolean NOT NULL,
	b_full_control boolean NOT NULL,
	sn_delete boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'pd_accesses');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN f_role OPTIONS (column_name 'f_role');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN c_criteria OPTIONS (column_name 'c_criteria');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN c_path OPTIONS (column_name 'c_path');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN c_function OPTIONS (column_name 'c_function');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN c_columns OPTIONS (column_name 'c_columns');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN b_deletable OPTIONS (column_name 'b_deletable');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN b_creatable OPTIONS (column_name 'b_creatable');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN b_editable OPTIONS (column_name 'b_editable');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN b_full_control OPTIONS (column_name 'b_full_control');

ALTER FOREIGN TABLE imp.pd_accesses ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.pd_accesses OWNER TO postgres;
