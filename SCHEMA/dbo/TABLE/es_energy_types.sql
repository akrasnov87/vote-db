CREATE TABLE dbo.es_energy_types (
	id integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_const text,
	b_default boolean NOT NULL
);

ALTER TABLE dbo.es_energy_types ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_energy_types_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_energy_types OWNER TO mobnius;

COMMENT ON TABLE dbo.es_energy_types IS 'Виды измерения';

COMMENT ON COLUMN dbo.es_energy_types.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.es_energy_types.n_code IS 'Код';

COMMENT ON COLUMN dbo.es_energy_types.c_const IS 'Константа';

COMMENT ON COLUMN dbo.es_energy_types.b_default IS 'Признак значения по-умолчанию';
