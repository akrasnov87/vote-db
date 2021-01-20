CREATE FOREIGN TABLE imp.cd_uik (
	id integer NOT NULL,
	c_fio text,
	c_email text,
	c_work_place text,
	c_job text,
	c_phone text,
	c_place text,
	c_place_phone text
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cd_uik');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_fio OPTIONS (column_name 'c_fio');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_email OPTIONS (column_name 'c_email');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_work_place OPTIONS (column_name 'c_work_place');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_job OPTIONS (column_name 'c_job');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_phone OPTIONS (column_name 'c_phone');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_place OPTIONS (column_name 'c_place');

ALTER FOREIGN TABLE imp.cd_uik ALTER COLUMN c_place_phone OPTIONS (column_name 'c_place_phone');

ALTER FOREIGN TABLE imp.cd_uik OWNER TO postgres;
