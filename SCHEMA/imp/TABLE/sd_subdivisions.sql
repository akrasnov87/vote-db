CREATE FOREIGN TABLE imp.sd_subdivisions (
	id integer NOT NULL,
	f_division integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	b_disabled boolean NOT NULL,
	c_email text,
	c_email_agitator text,
	c_email_agitator_v2 text
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'sd_subdivisions');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN n_code OPTIONS (column_name 'n_code');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN c_email OPTIONS (column_name 'c_email');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN c_email_agitator OPTIONS (column_name 'c_email_agitator');

ALTER FOREIGN TABLE imp.sd_subdivisions ALTER COLUMN c_email_agitator_v2 OPTIONS (column_name 'c_email_agitator_v2');

ALTER FOREIGN TABLE imp.sd_subdivisions OWNER TO postgres;
