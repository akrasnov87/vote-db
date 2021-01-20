CREATE FOREIGN TABLE imp.cv_people (
	c_people_type text,
	c_area text,
	c_street_type text,
	c_street_name text,
	f_street uuid,
	c_house_num text,
	c_house_build text,
	f_house uuid,
	c_appartament_num text,
	f_appartament uuid,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	c_phone text,
	n_birth_year integer,
	c_org text,
	n_uik integer,
	c_subdivision text
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_people');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_people_type OPTIONS (column_name 'c_people_type');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_area OPTIONS (column_name 'c_area');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_street_type OPTIONS (column_name 'c_street_type');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_street_name OPTIONS (column_name 'c_street_name');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN f_street OPTIONS (column_name 'f_street');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_house_build OPTIONS (column_name 'c_house_build');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN f_house OPTIONS (column_name 'f_house');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_appartament_num OPTIONS (column_name 'c_appartament_num');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN f_appartament OPTIONS (column_name 'f_appartament');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_first_name OPTIONS (column_name 'c_first_name');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_last_name OPTIONS (column_name 'c_last_name');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_patronymic OPTIONS (column_name 'c_patronymic');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_phone OPTIONS (column_name 'c_phone');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN n_birth_year OPTIONS (column_name 'n_birth_year');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_org OPTIONS (column_name 'c_org');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_people ALTER COLUMN c_subdivision OPTIONS (column_name 'c_subdivision');

ALTER FOREIGN TABLE imp.cv_people OWNER TO postgres;
