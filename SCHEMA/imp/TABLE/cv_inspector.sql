CREATE FOREIGN TABLE imp.cv_inspector (
	id integer,
	c_login text,
	c_email text,
	c_tel text,
	c_description text,
	n_uik integer,
	c_divisions text,
	c_subdivisions text,
	b_disabled boolean
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_inspector');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN c_email OPTIONS (column_name 'c_email');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN c_tel OPTIONS (column_name 'c_tel');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN c_divisions OPTIONS (column_name 'c_divisions');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN c_subdivisions OPTIONS (column_name 'c_subdivisions');

ALTER FOREIGN TABLE imp.cv_inspector ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cv_inspector OWNER TO postgres;
