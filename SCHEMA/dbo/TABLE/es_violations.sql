CREATE TABLE dbo.es_violations (
	id integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.es_violations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_violations_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_violations OWNER TO mobnius;

COMMENT ON TABLE dbo.es_violations IS 'Типы нарушений';

COMMENT ON COLUMN dbo.es_violations.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.es_violations.n_code IS 'Код';

COMMENT ON COLUMN dbo.es_violations.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.es_violations.c_short_name IS 'Краткое наименование';

COMMENT ON COLUMN dbo.es_violations.c_const IS 'Константа';

COMMENT ON COLUMN dbo.es_violations.n_order IS 'Сортировка';

COMMENT ON COLUMN dbo.es_violations.b_default IS 'По умолчанию';

COMMENT ON COLUMN dbo.es_violations.b_disabled IS 'Отключено';
