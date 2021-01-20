CREATE TABLE dbo.es_device_types (
	id integer NOT NULL,
	f_device_categories integer NOT NULL,
	c_name text,
	c_modification text,
	n_check_cycle integer,
	f_tariff_zone integer,
	b_phase3 boolean,
	b_disabled boolean NOT NULL,
	f_device_types integer,
	n_tariff integer,
	n_digits numeric(5,2),
	n_tt1 numeric(19,6),
	n_tt2 numeric(19,6),
	n_rate numeric(10,2)
);

ALTER TABLE dbo.es_device_types ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_device_types_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_device_types OWNER TO mobnius;

COMMENT ON TABLE dbo.es_device_types IS 'Типы прибора';

COMMENT ON COLUMN dbo.es_device_types.f_device_categories IS 'Категория';

COMMENT ON COLUMN dbo.es_device_types.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.es_device_types.c_modification IS 'Модификация';

COMMENT ON COLUMN dbo.es_device_types.n_check_cycle IS 'Межповерочный интервал, лет';

COMMENT ON COLUMN dbo.es_device_types.f_tariff_zone IS 'Количество временных зон';

COMMENT ON COLUMN dbo.es_device_types.b_phase3 IS 'Признак: Трехфазный';

COMMENT ON COLUMN dbo.es_device_types.n_tariff IS 'Количество тарифных зон';

COMMENT ON COLUMN dbo.es_device_types.n_digits IS 'Разрядность';

COMMENT ON COLUMN dbo.es_device_types.n_tt1 IS 'Величина на первичнй обмотке';

COMMENT ON COLUMN dbo.es_device_types.n_tt2 IS 'Величина на вторичной обмотке';

COMMENT ON COLUMN dbo.es_device_types.n_rate IS 'Коэффициент трансформации';
