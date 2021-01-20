CREATE FOREIGN TABLE imp.msv_union_appartament (
	f_appartament uuid,
	f_type text,
	n_type integer,
	d_date timestamp with time zone
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'msv_union_appartament');

ALTER FOREIGN TABLE imp.msv_union_appartament ALTER COLUMN f_appartament OPTIONS (column_name 'f_appartament');

ALTER FOREIGN TABLE imp.msv_union_appartament ALTER COLUMN f_type OPTIONS (column_name 'f_type');

ALTER FOREIGN TABLE imp.msv_union_appartament ALTER COLUMN n_type OPTIONS (column_name 'n_type');

ALTER FOREIGN TABLE imp.msv_union_appartament ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.msv_union_appartament OWNER TO postgres;
