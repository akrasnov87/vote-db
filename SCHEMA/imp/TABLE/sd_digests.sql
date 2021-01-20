CREATE FOREIGN TABLE imp.sd_digests (
	id integer NOT NULL,
	c_version text NOT NULL,
	c_description text NOT NULL,
	f_division integer,
	c_app_name text NOT NULL,
	b_hidden boolean NOT NULL,
	ba_file bytea NOT NULL,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'sd_digests');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN c_version OPTIONS (column_name 'c_version');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN f_division OPTIONS (column_name 'f_division');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN c_app_name OPTIONS (column_name 'c_app_name');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN b_hidden OPTIONS (column_name 'b_hidden');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN ba_file OPTIONS (column_name 'ba_file');

ALTER FOREIGN TABLE imp.sd_digests ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.sd_digests OWNER TO postgres;
