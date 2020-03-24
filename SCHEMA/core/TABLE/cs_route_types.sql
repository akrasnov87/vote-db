CREATE TABLE core.cs_route_types (
	id integer DEFAULT nextval('core.auto_id_cs_route_types'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_default boolean NOT NULL DEFAULT false,
	b_disabled boolean NOT NULL DEFAULT false
);

ALTER TABLE core.cs_route_types OWNER TO mobnius;

COMMENT ON TABLE core.cs_route_types IS 'Тип маршрута';

COMMENT ON COLUMN core.cs_route_types.id IS '[e80] Идентификатор';

COMMENT ON COLUMN core.cs_route_types.n_code IS '[e70] Код';

COMMENT ON COLUMN core.cs_route_types.c_name IS '[e60|d] Наименование';

COMMENT ON COLUMN core.cs_route_types.c_short_name IS '[e50] Краткое наименование';

COMMENT ON COLUMN core.cs_route_types.c_const IS '[e40] Константа';

COMMENT ON COLUMN core.cs_route_types.n_order IS '[e30] Сортировка';

COMMENT ON COLUMN core.cs_route_types.b_default IS '[e20] По умолчанию';

COMMENT ON COLUMN core.cs_route_types.b_disabled IS '[e10] Отключено';

--------------------------------------------------------------------------------

CREATE TRIGGER cs_route_types_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cs_route_types
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cs_route_types
	ADD CONSTRAINT cs_route_types_pkey PRIMARY KEY (id);
