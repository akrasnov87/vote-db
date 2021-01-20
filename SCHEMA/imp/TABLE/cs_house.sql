CREATE FOREIGN TABLE imp.cs_house (
	id uuid NOT NULL,
	f_street uuid,
	c_house_num text,
	c_build_num text,
	dx_date timestamp with time zone NOT NULL,
	b_disabled boolean NOT NULL,
	n_uik integer,
	c_floor text,
	c_porch text,
	f_subdivision integer,
	f_user integer,
	f_candidate_users jsonb,
	b_correct_uik boolean NOT NULL,
	n_uik_correct integer,
	n_latitude numeric,
	n_longitude numeric,
	jb_yandex_res jsonb,
	c_yandex_description text,
	c_yandex_name text,
	b_yandex boolean NOT NULL,
	b_yandex_fail boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cs_house');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN f_street OPTIONS (column_name 'f_street');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN c_build_num OPTIONS (column_name 'c_build_num');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN dx_date OPTIONS (column_name 'dx_date');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN c_floor OPTIONS (column_name 'c_floor');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN c_porch OPTIONS (column_name 'c_porch');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN f_candidate_users OPTIONS (column_name 'f_candidate_users');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN b_correct_uik OPTIONS (column_name 'b_correct_uik');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN n_uik_correct OPTIONS (column_name 'n_uik_correct');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN n_latitude OPTIONS (column_name 'n_latitude');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN n_longitude OPTIONS (column_name 'n_longitude');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN jb_yandex_res OPTIONS (column_name 'jb_yandex_res');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN c_yandex_description OPTIONS (column_name 'c_yandex_description');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN c_yandex_name OPTIONS (column_name 'c_yandex_name');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN b_yandex OPTIONS (column_name 'b_yandex');

ALTER FOREIGN TABLE imp.cs_house ALTER COLUMN b_yandex_fail OPTIONS (column_name 'b_yandex_fail');

ALTER FOREIGN TABLE imp.cs_house OWNER TO postgres;
