CREATE FOREIGN TABLE imp.pd_userinroles (
	id integer NOT NULL,
	f_user integer NOT NULL,
	f_role integer NOT NULL,
	sn_delete boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'pd_userinroles');

ALTER FOREIGN TABLE imp.pd_userinroles ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.pd_userinroles ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.pd_userinroles ALTER COLUMN f_role OPTIONS (column_name 'f_role');

ALTER FOREIGN TABLE imp.pd_userinroles ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE imp.pd_userinroles OWNER TO postgres;
