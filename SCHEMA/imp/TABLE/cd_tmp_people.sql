CREATE FOREIGN TABLE imp.cd_tmp_people (
	id uuid NOT NULL,
	f_street uuid,
	f_house uuid,
	f_appartament uuid,
	c_city text,
	n_uik integer,
	c_type text,
	c_name text,
	c_house_num text,
	c_build_num text,
	c_appartament text,
	n_appartament integer,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	f_user integer,
	dx_created timestamp with time zone NOT NULL,
	n_birth_year integer,
	c_org text,
	c_phone text,
	c_notice text,
	b_disabled boolean NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cd_tmp_people');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN f_street OPTIONS (column_name 'f_street');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN f_house OPTIONS (column_name 'f_house');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN f_appartament OPTIONS (column_name 'f_appartament');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_city OPTIONS (column_name 'c_city');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_type OPTIONS (column_name 'c_type');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_build_num OPTIONS (column_name 'c_build_num');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_appartament OPTIONS (column_name 'c_appartament');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN n_appartament OPTIONS (column_name 'n_appartament');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_first_name OPTIONS (column_name 'c_first_name');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_last_name OPTIONS (column_name 'c_last_name');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_patronymic OPTIONS (column_name 'c_patronymic');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN n_birth_year OPTIONS (column_name 'n_birth_year');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_org OPTIONS (column_name 'c_org');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_phone OPTIONS (column_name 'c_phone');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE imp.cd_tmp_people ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cd_tmp_people OWNER TO postgres;
