CREATE FOREIGN TABLE imp.cv_userinroutes (
	id integer,
	c_login text,
	c_fio text,
	n_uik integer,
	f_subdivision integer,
	c_claims text,
	f_type integer,
	c_route_type_name text,
	c_number text,
	n_all bigint,
	n_count bigint,
	n_today_count bigint
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_userinroutes');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN c_fio OPTIONS (column_name 'c_fio');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN c_claims OPTIONS (column_name 'c_claims');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN f_type OPTIONS (column_name 'f_type');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN c_route_type_name OPTIONS (column_name 'c_route_type_name');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN c_number OPTIONS (column_name 'c_number');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN n_all OPTIONS (column_name 'n_all');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN n_count OPTIONS (column_name 'n_count');

ALTER FOREIGN TABLE imp.cv_userinroutes ALTER COLUMN n_today_count OPTIONS (column_name 'n_today_count');

ALTER FOREIGN TABLE imp.cv_userinroutes OWNER TO postgres;
