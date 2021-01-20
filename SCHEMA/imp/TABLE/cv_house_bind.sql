CREATE FOREIGN TABLE imp.cv_house_bind (
	id uuid,
	f_street uuid,
	c_street_name text,
	c_street_type text,
	c_house_num text,
	c_build_num text,
	n_uik integer,
	f_subdivision integer,
	n_appartament_count bigint,
	n_appartament_min integer,
	n_appartament_max integer,
	f_users json
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_house_bind');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN f_street OPTIONS (column_name 'f_street');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN c_street_name OPTIONS (column_name 'c_street_name');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN c_street_type OPTIONS (column_name 'c_street_type');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN c_build_num OPTIONS (column_name 'c_build_num');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN n_appartament_count OPTIONS (column_name 'n_appartament_count');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN n_appartament_min OPTIONS (column_name 'n_appartament_min');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN n_appartament_max OPTIONS (column_name 'n_appartament_max');

ALTER FOREIGN TABLE imp.cv_house_bind ALTER COLUMN f_users OPTIONS (column_name 'f_users');

ALTER FOREIGN TABLE imp.cv_house_bind OWNER TO postgres;
