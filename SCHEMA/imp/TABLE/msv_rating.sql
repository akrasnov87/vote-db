CREATE FOREIGN TABLE imp.msv_rating (
	user_id integer,
	c_login text,
	f_subdivision integer,
	c_subdivision text,
	n_uik integer,
	c_claims text,
	n_all bigint,
	n_count bigint,
	n_today_count bigint
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'msv_rating');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN user_id OPTIONS (column_name 'user_id');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN c_subdivision OPTIONS (column_name 'c_subdivision');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN c_claims OPTIONS (column_name 'c_claims');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN n_all OPTIONS (column_name 'n_all');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN n_count OPTIONS (column_name 'n_count');

ALTER FOREIGN TABLE imp.msv_rating ALTER COLUMN n_today_count OPTIONS (column_name 'n_today_count');

ALTER FOREIGN TABLE imp.msv_rating OWNER TO postgres;
