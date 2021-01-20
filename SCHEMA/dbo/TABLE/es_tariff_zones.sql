CREATE TABLE dbo.es_tariff_zones (
	id integer DEFAULT nextval('dbo.auto_id_es_tariff_zones'::regclass) NOT NULL,
	n_count_scale integer NOT NULL,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.es_tariff_zones OWNER TO mobnius;

COMMENT ON TABLE dbo.es_tariff_zones IS 'Тарифные зоны';

COMMENT ON COLUMN dbo.es_tariff_zones.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.es_tariff_zones.n_count_scale IS 'Код';

COMMENT ON COLUMN dbo.es_tariff_zones.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.es_tariff_zones.c_short_name IS 'Краткое наименование';

COMMENT ON COLUMN dbo.es_tariff_zones.c_const IS 'Константа';

COMMENT ON COLUMN dbo.es_tariff_zones.n_order IS 'Сортировка';

COMMENT ON COLUMN dbo.es_tariff_zones.b_default IS 'По умолчанию';

COMMENT ON COLUMN dbo.es_tariff_zones.b_disabled IS 'Отключено';
