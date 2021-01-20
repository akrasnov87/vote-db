CREATE FOREIGN TABLE imp.pd_userindivisions (
	id integer NOT NULL,
	f_user integer NOT NULL,
	f_division integer NOT NULL,
	f_subdivision integer,
	sn_delete boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'pd_userindivisions');

ALTER FOREIGN TABLE imp.pd_userindivisions ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.pd_userindivisions ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.pd_userindivisions ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.pd_userindivisions ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.pd_userindivisions ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.pd_userindivisions OWNER TO postgres;
