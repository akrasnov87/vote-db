CREATE TABLE dbo.es_scales (
	id integer DEFAULT nextval('dbo.auto_id_es_scales'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.es_scales OWNER TO mobnius;

COMMENT ON TABLE dbo.es_scales IS 'Шкалы прибора учета';

COMMENT ON COLUMN dbo.es_scales.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.es_scales.n_code IS 'Код';

COMMENT ON COLUMN dbo.es_scales.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.es_scales.c_short_name IS 'Краткое наименование';

COMMENT ON COLUMN dbo.es_scales.c_const IS 'Константа';

COMMENT ON COLUMN dbo.es_scales.n_order IS 'Сортировка';

COMMENT ON COLUMN dbo.es_scales.b_default IS 'По умолчанию';

COMMENT ON COLUMN dbo.es_scales.b_disabled IS 'Отключено';
