CREATE FOREIGN TABLE imp.cd_people (
	id uuid NOT NULL,
	f_street uuid NOT NULL,
	f_house uuid NOT NULL,
	f_appartament uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	f_user integer NOT NULL,
	dx_created timestamp with time zone NOT NULL,
	n_birth_year integer,
	c_org text,
	c_phone text,
	f_type integer NOT NULL,
	b_vote_2020 boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cd_people');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN f_street OPTIONS (column_name 'f_street');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN f_house OPTIONS (column_name 'f_house');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN f_appartament OPTIONS (column_name 'f_appartament');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN c_first_name OPTIONS (column_name 'c_first_name');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN c_last_name OPTIONS (column_name 'c_last_name');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN c_patronymic OPTIONS (column_name 'c_patronymic');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN n_birth_year OPTIONS (column_name 'n_birth_year');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN c_org OPTIONS (column_name 'c_org');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN c_phone OPTIONS (column_name 'c_phone');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN f_type OPTIONS (column_name 'f_type');

ALTER FOREIGN TABLE imp.cd_people ALTER COLUMN b_vote_2020 OPTIONS (column_name 'b_vote_2020');

ALTER FOREIGN TABLE imp.cd_people OWNER TO postgres;
