CREATE FOREIGN TABLE imp.cv_house (
	id uuid,
	street_id uuid,
	c_street_type text,
	street_name text,
	c_house_num text,
	c_build_num text,
	n_uik integer,
	c_floor text,
	c_porch text,
	f_subdivision integer,
	f_division integer,
	c_subdivision text,
	b_fail boolean,
	n_appartament bigint,
	b_private boolean,
	b_disabled boolean,
	street_b_disabled boolean
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'cv_house');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN street_id OPTIONS (column_name 'street_id');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN c_street_type OPTIONS (column_name 'c_street_type');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN street_name OPTIONS (column_name 'street_name');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN c_build_num OPTIONS (column_name 'c_build_num');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN c_floor OPTIONS (column_name 'c_floor');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN c_porch OPTIONS (column_name 'c_porch');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN c_subdivision OPTIONS (column_name 'c_subdivision');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN b_fail OPTIONS (column_name 'b_fail');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN n_appartament OPTIONS (column_name 'n_appartament');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN b_private OPTIONS (column_name 'b_private');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.cv_house ALTER COLUMN street_b_disabled OPTIONS (column_name 'street_b_disabled');

ALTER FOREIGN TABLE imp.cv_house OWNER TO postgres;
