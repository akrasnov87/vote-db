CREATE FOREIGN TABLE imp.ad_mobile_indicators (
	id uuid NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_network_type text,
	b_isonline boolean NOT NULL,
	n_ram bigint,
	n_used_ram bigint,
	n_phone_memory bigint,
	n_used_phone_memory bigint,
	n_sd_card_memory bigint,
	n_used_sd_card_memory bigint,
	n_battery_level integer,
	n_time integer,
	dx_created timestamp with time zone NOT NULL
)
SERVER import_server
OPTIONS (schema_name 'core', table_name 'ad_mobile_indicators');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN fn_user OPTIONS (column_name 'fn_user');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN c_network_type OPTIONS (column_name 'c_network_type');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN b_isonline OPTIONS (column_name 'b_isonline');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_ram OPTIONS (column_name 'n_ram');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_used_ram OPTIONS (column_name 'n_used_ram');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_phone_memory OPTIONS (column_name 'n_phone_memory');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_used_phone_memory OPTIONS (column_name 'n_used_phone_memory');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_sd_card_memory OPTIONS (column_name 'n_sd_card_memory');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_used_sd_card_memory OPTIONS (column_name 'n_used_sd_card_memory');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_battery_level OPTIONS (column_name 'n_battery_level');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN n_time OPTIONS (column_name 'n_time');

ALTER FOREIGN TABLE imp.ad_mobile_indicators ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE imp.ad_mobile_indicators OWNER TO postgres;
