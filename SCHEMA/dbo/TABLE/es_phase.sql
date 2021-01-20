CREATE TABLE dbo.es_phase (
	id integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_const text
);

ALTER TABLE dbo.es_phase ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_phase_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_phase OWNER TO mobnius;

COMMENT ON TABLE dbo.es_phase IS 'Фазы';

COMMENT ON COLUMN dbo.es_phase.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.es_phase.n_code IS 'Код';

COMMENT ON COLUMN dbo.es_phase.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.es_phase.c_const IS 'Константа';
