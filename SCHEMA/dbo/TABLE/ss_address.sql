CREATE TABLE dbo.ss_address (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text,
	c_index text,
	c_region text,
	code_fias_region text,
	c_raion text,
	data_area_fias_id text,
	c_city_name text,
	data_city_fias_id text,
	c_settlement_name text,
	settlement_fias_id text,
	c_street_name text,
	data_street_fias_id text,
	c_house_name text,
	data_house_fias_id text,
	c_block_name text,
	c_flat_name text,
	n_fias_level integer,
	n_geo_lat numeric(19,6),
	n_geo_lon numeric(19,6),
	qc_geo integer,
	imp_int integer,
	c_comment_address text
);

ALTER TABLE dbo.ss_address OWNER TO mobnius;

COMMENT ON TABLE dbo.ss_address IS 'Адреса';

COMMENT ON COLUMN dbo.ss_address.id IS 'ID';

COMMENT ON COLUMN dbo.ss_address.c_name IS 'Полный адрес';

COMMENT ON COLUMN dbo.ss_address.c_index IS 'Индекс';

COMMENT ON COLUMN dbo.ss_address.c_region IS 'Наименование области';

COMMENT ON COLUMN dbo.ss_address.code_fias_region IS 'Код ФИАС региона';

COMMENT ON COLUMN dbo.ss_address.c_raion IS 'Наименование района';

COMMENT ON COLUMN dbo.ss_address.c_city_name IS 'Наименование города';

COMMENT ON COLUMN dbo.ss_address.data_city_fias_id IS 'Код ФИАС города';

COMMENT ON COLUMN dbo.ss_address.c_settlement_name IS 'Наименование населенного пункта';

COMMENT ON COLUMN dbo.ss_address.settlement_fias_id IS 'Код ФИАС населенного пункта';

COMMENT ON COLUMN dbo.ss_address.c_street_name IS 'Наименование улицы';

COMMENT ON COLUMN dbo.ss_address.data_street_fias_id IS 'Код ФИАС улицы';

COMMENT ON COLUMN dbo.ss_address.c_house_name IS 'Номер дома';

COMMENT ON COLUMN dbo.ss_address.data_house_fias_id IS 'Код ФИАС дома';

COMMENT ON COLUMN dbo.ss_address.c_block_name IS 'Корпус';

COMMENT ON COLUMN dbo.ss_address.c_flat_name IS 'Квартира';

COMMENT ON COLUMN dbo.ss_address.n_fias_level IS 'Уровень ФИАС';

COMMENT ON COLUMN dbo.ss_address.n_geo_lat IS 'Широта';

COMMENT ON COLUMN dbo.ss_address.n_geo_lon IS 'Долгота';

COMMENT ON COLUMN dbo.ss_address.qc_geo IS 'Точность координат';

COMMENT ON COLUMN dbo.ss_address.imp_int IS 'временное поле для импорта';

COMMENT ON COLUMN dbo.ss_address.c_comment_address IS 'Комментарий к адресу';
