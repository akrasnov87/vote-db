CREATE FOREIGN TABLE imp.cd_contacts (
	id uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	fn_street uuid NOT NULL,
	c_appartament text NOT NULL,
	n_rating integer,
	c_description text,
	d_date timestamp with time zone NOT NULL,
	dx_created timestamp with time zone NOT NULL,
	fn_user integer NOT NULL,
	jb_data jsonb,
	c_phone text,
	b_disabled boolean NOT NULL,
	c_house_num text,
	c_house_build text,
	n_order bigint
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cd_contacts');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_first_name OPTIONS (column_name 'c_first_name');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_last_name OPTIONS (column_name 'c_last_name');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_patronymic OPTIONS (column_name 'c_patronymic');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN fn_street OPTIONS (column_name 'fn_street');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_appartament OPTIONS (column_name 'c_appartament');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN n_rating OPTIONS (column_name 'n_rating');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_phone OPTIONS (column_name 'c_phone');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN c_house_build OPTIONS (column_name 'c_house_build');

ALTER FOREIGN TABLE imp.cd_contacts ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE imp.cd_contacts OWNER TO postgres;
