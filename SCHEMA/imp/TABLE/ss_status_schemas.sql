CREATE FOREIGN TABLE imp.ss_status_schemas (
	id integer NOT NULL,
	f_start integer NOT NULL,
	f_end integer NOT NULL,
	b_disabled boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'ss_status_schemas');

ALTER FOREIGN TABLE imp.ss_status_schemas ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.ss_status_schemas ALTER COLUMN f_start OPTIONS (column_name 'f_start');

ALTER FOREIGN TABLE imp.ss_status_schemas ALTER COLUMN f_end OPTIONS (column_name 'f_end');

ALTER FOREIGN TABLE imp.ss_status_schemas ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.ss_status_schemas OWNER TO postgres;
