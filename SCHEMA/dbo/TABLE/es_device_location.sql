CREATE TABLE dbo.es_device_location (
	id integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_const text,
	b_default boolean NOT NULL,
	f_division integer,
	f_subdivision integer
);

ALTER TABLE dbo.es_device_location ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_device_location_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_device_location OWNER TO mobnius;

COMMENT ON TABLE dbo.es_device_location IS 'Место установки';

COMMENT ON COLUMN dbo.es_device_location.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.es_device_location.n_code IS 'Код';

COMMENT ON COLUMN dbo.es_device_location.c_const IS 'Константа';

COMMENT ON COLUMN dbo.es_device_location.b_default IS 'Признак значения по-умолчанию';

COMMENT ON COLUMN dbo.es_device_location.f_division IS 'Ссылка на филиал/отделение ЦиП';

COMMENT ON COLUMN dbo.es_device_location.f_subdivision IS 'Ссылка на участок/РЭС ЦиП';
