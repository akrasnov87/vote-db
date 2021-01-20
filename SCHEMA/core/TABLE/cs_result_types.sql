CREATE TABLE core.cs_result_types (
	id integer DEFAULT nextval('core.auto_id_cs_result_types'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.cs_result_types OWNER TO mobnius;

COMMENT ON TABLE core.cs_result_types IS 'Тип результат';

COMMENT ON COLUMN core.cs_result_types.id IS 'Идентификатор';

COMMENT ON COLUMN core.cs_result_types.n_code IS 'Код';

COMMENT ON COLUMN core.cs_result_types.c_name IS 'Наименование';

COMMENT ON COLUMN core.cs_result_types.c_short_name IS 'Краткое наименование';

COMMENT ON COLUMN core.cs_result_types.c_const IS 'Константа';

COMMENT ON COLUMN core.cs_result_types.n_order IS 'Отключено';

COMMENT ON COLUMN core.cs_result_types.b_default IS 'По умолчанию';

COMMENT ON COLUMN core.cs_result_types.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

CREATE TRIGGER cs_result_types_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cs_result_types
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cs_result_types
	ADD CONSTRAINT cs_result_types_pkey PRIMARY KEY (id);
