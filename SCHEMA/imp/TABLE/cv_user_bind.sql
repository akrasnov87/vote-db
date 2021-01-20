CREATE FOREIGN TABLE imp.cv_user_bind (
	user_id integer,
	c_division text,
	c_subdivision text,
	n_uik integer,
	c_type text,
	c_street text,
	c_house_num text,
	c_build_num text,
	c_appartament text,
	n_appartament bigint
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_user_bind');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN user_id OPTIONS (column_name 'user_id');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_division OPTIONS (column_name 'c_division');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_subdivision OPTIONS (column_name 'c_subdivision');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_type OPTIONS (column_name 'c_type');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_street OPTIONS (column_name 'c_street');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_build_num OPTIONS (column_name 'c_build_num');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN c_appartament OPTIONS (column_name 'c_appartament');

ALTER FOREIGN TABLE imp.cv_user_bind ALTER COLUMN n_appartament OPTIONS (column_name 'n_appartament');

ALTER FOREIGN TABLE imp.cv_user_bind OWNER TO postgres;
