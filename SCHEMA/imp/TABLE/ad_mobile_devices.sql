CREATE FOREIGN TABLE imp.ad_mobile_devices (
	id uuid NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	b_debug boolean NOT NULL,
	c_architecture text,
	c_phone_model text,
	c_sdk text,
	c_os text,
	c_imei text,
	c_application_version text,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'ad_mobile_devices');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN b_debug OPTIONS (column_name 'b_debug');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN c_architecture OPTIONS (column_name 'c_architecture');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN c_phone_model OPTIONS (column_name 'c_phone_model');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN c_sdk OPTIONS (column_name 'c_sdk');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN c_os OPTIONS (column_name 'c_os');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN c_imei OPTIONS (column_name 'c_imei');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN c_application_version OPTIONS (column_name 'c_application_version');

ALTER FOREIGN TABLE imp.ad_mobile_devices ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.ad_mobile_devices OWNER TO postgres;
