CREATE FOREIGN TABLE imp.msv_appartament (
	id uuid,
	c_area text,
	c_street_type text,
	c_street_name text,
	f_street uuid,
	c_house_num text,
	c_house_build text,
	f_house uuid,
	c_appartament text,
	n_appartament integer,
	n_uik integer,
	f_subdivision integer,
	c_subdivision text,
	n_signature integer,
	jb_food_kit json,
	jb_other json,
	jb_er json,
	jb_budget json
)
SERVER import_server
OPTIONS (schema_name 'dbo', table_name 'msv_appartament');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_area OPTIONS (column_name 'c_area');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_street_type OPTIONS (column_name 'c_street_type');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_street_name OPTIONS (column_name 'c_street_name');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN f_street OPTIONS (column_name 'f_street');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_house_num OPTIONS (column_name 'c_house_num');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_house_build OPTIONS (column_name 'c_house_build');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN f_house OPTIONS (column_name 'f_house');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_appartament OPTIONS (column_name 'c_appartament');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN n_appartament OPTIONS (column_name 'n_appartament');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN n_uik OPTIONS (column_name 'n_uik');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN f_subdivision OPTIONS (column_name 'f_subdivision');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN c_subdivision OPTIONS (column_name 'c_subdivision');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN n_signature OPTIONS (column_name 'n_signature');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN jb_food_kit OPTIONS (column_name 'jb_food_kit');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN jb_other OPTIONS (column_name 'jb_other');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN jb_er OPTIONS (column_name 'jb_er');

ALTER FOREIGN TABLE imp.msv_appartament ALTER COLUMN jb_budget OPTIONS (column_name 'jb_budget');

ALTER FOREIGN TABLE imp.msv_appartament OWNER TO postgres;
