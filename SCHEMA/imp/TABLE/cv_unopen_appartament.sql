CREATE FOREIGN TABLE imp.cv_unopen_appartament (
	fn_user integer,
	f_appartament uuid
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_unopen_appartament');

ALTER FOREIGN TABLE imp.cv_unopen_appartament ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.cv_unopen_appartament ALTER COLUMN f_appartament OPTIONS (column_name 'f_appartament');

ALTER FOREIGN TABLE imp.cv_unopen_appartament OWNER TO postgres;
