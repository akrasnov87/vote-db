CREATE TABLE dbo.cs_people_types (
	id integer DEFAULT nextval('dbo.auto_id_cs_people_types'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cs_people_types OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_people_types IS 'Тип маршрута';

COMMENT ON COLUMN dbo.cs_people_types.id IS '[e80] Идентификатор';

COMMENT ON COLUMN dbo.cs_people_types.n_code IS '[e70] Код';

COMMENT ON COLUMN dbo.cs_people_types.c_name IS '[e60|d] Наименование';

COMMENT ON COLUMN dbo.cs_people_types.c_short_name IS '[e50] Краткое наименование';

COMMENT ON COLUMN dbo.cs_people_types.c_const IS '[e40] Константа';

COMMENT ON COLUMN dbo.cs_people_types.n_order IS '[e30] Сортировка';

COMMENT ON COLUMN dbo.cs_people_types.b_default IS '[e20] По умолчанию';

COMMENT ON COLUMN dbo.cs_people_types.b_disabled IS '[e10] Отключено';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_people_types
	ADD CONSTRAINT cs_people_types_pkey PRIMARY KEY (id);
