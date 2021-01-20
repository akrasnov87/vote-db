CREATE FOREIGN TABLE imp.cs_street (
	id uuid NOT NULL,
	c_name text,
	c_type text,
	dx_date timestamp with time zone NOT NULL,
	b_disabled boolean NOT NULL,
	f_division integer NOT NULL,
	c_short_type text,
	f_user integer,
	b_yandex boolean NOT NULL,
	b_yandex_fail boolean NOT NULL,
	jb_yandex_res jsonb,
	n_latitude numeric,
	n_longitude numeric,
	c_yandex_description text,
	c_yandex_name text
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cs_street');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN c_type OPTIONS (column_name 'c_type');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN dx_date OPTIONS (column_name 'dx_date');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN c_short_type OPTIONS (column_name 'c_short_type');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN b_yandex OPTIONS (column_name 'b_yandex');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN b_yandex_fail OPTIONS (column_name 'b_yandex_fail');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN jb_yandex_res OPTIONS (column_name 'jb_yandex_res');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN n_latitude OPTIONS (column_name 'n_latitude');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN n_longitude OPTIONS (column_name 'n_longitude');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN c_yandex_description OPTIONS (column_name 'c_yandex_description');

ALTER FOREIGN TABLE imp.cs_street ALTER COLUMN c_yandex_name OPTIONS (column_name 'c_yandex_name');

ALTER FOREIGN TABLE imp.cs_street OWNER TO postgres;
