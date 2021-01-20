CREATE FOREIGN TABLE imp.cd_userinroutes (
	id uuid NOT NULL,
	f_route uuid NOT NULL,
	f_user integer NOT NULL,
	b_main boolean NOT NULL,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'cd_userinroutes');

ALTER FOREIGN TABLE imp.cd_userinroutes ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_userinroutes ALTER COLUMN f_route OPTIONS (column_name 'f_route');

ALTER FOREIGN TABLE imp.cd_userinroutes ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cd_userinroutes ALTER COLUMN b_main OPTIONS (column_name 'b_main');

ALTER FOREIGN TABLE imp.cd_userinroutes ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_userinroutes OWNER TO postgres;
