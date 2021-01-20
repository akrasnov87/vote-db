CREATE FOREIGN TABLE imp.cs_main_candidate (
	id uuid NOT NULL,
	n_subdivision integer NOT NULL,
	c_fio text NOT NULL,
	c_status text NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cs_main_candidate');

ALTER FOREIGN TABLE imp.cs_main_candidate ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cs_main_candidate ALTER COLUMN n_subdivision OPTIONS (column_name 'n_subdivision');

ALTER FOREIGN TABLE imp.cs_main_candidate ALTER COLUMN c_fio OPTIONS (column_name 'c_fio');

ALTER FOREIGN TABLE imp.cs_main_candidate ALTER COLUMN c_status OPTIONS (column_name 'c_status');

ALTER FOREIGN TABLE imp.cs_main_candidate OWNER TO postgres;
