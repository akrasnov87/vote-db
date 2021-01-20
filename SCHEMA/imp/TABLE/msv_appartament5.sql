CREATE FOREIGN TABLE imp.msv_appartament5 (
	id uuid,
	f_house uuid,
	c_number text,
	n_number integer,
	dx_date timestamp with time zone,
	b_disabled boolean,
	f_user integer,
	n_signature_2018 integer,
	f_main_user integer
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'msv_appartament5');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN f_house OPTIONS (column_name 'f_house');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN c_number OPTIONS (column_name 'c_number');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN n_number OPTIONS (column_name 'n_number');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN dx_date OPTIONS (column_name 'dx_date');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN n_signature_2018 OPTIONS (column_name 'n_signature_2018');

ALTER FOREIGN TABLE imp.msv_appartament5 ALTER COLUMN f_main_user OPTIONS (column_name 'f_main_user');

ALTER FOREIGN TABLE imp.msv_appartament5 OWNER TO postgres;
