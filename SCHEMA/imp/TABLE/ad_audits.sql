CREATE FOREIGN TABLE imp.ad_audits (
	id bigint NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_data text,
	c_type text NOT NULL,
	c_app_name text NOT NULL,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'ad_audits');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN c_data OPTIONS (column_name 'c_data');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN c_type OPTIONS (column_name 'c_type');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN c_app_name OPTIONS (column_name 'c_app_name');

ALTER FOREIGN TABLE imp.ad_audits ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.ad_audits OWNER TO postgres;
