CREATE TABLE dbo.es_seal_types (
	id integer DEFAULT nextval('dbo.auto_id_es_seal_types'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.es_seal_types OWNER TO mobnius;

COMMENT ON TABLE dbo.es_seal_types IS 'тип пломбы';

COMMENT ON COLUMN dbo.es_seal_types.id IS '[e80] Идентификатор';

COMMENT ON COLUMN dbo.es_seal_types.n_code IS '[e70] Код';

COMMENT ON COLUMN dbo.es_seal_types.c_name IS '[e60|d] Наименование';

COMMENT ON COLUMN dbo.es_seal_types.c_short_name IS '[e50] Краткое наименование';

COMMENT ON COLUMN dbo.es_seal_types.c_const IS '[e40] Константа';

COMMENT ON COLUMN dbo.es_seal_types.n_order IS '[e30] Сортировка';

COMMENT ON COLUMN dbo.es_seal_types.b_default IS '[e20] Отключено';

COMMENT ON COLUMN dbo.es_seal_types.b_disabled IS '[e10] Отключено';
