CREATE TABLE core.cs_route_statuses (
	id integer DEFAULT nextval('core.auto_id_cs_route_statuses'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_disabled boolean NOT NULL DEFAULT false
);

ALTER TABLE core.cs_route_statuses OWNER TO mobnius;

COMMENT ON TABLE core.cs_route_statuses IS 'Тип результат';

COMMENT ON COLUMN core.cs_route_statuses.id IS '[e60] Идентификатор';

COMMENT ON COLUMN core.cs_route_statuses.n_code IS '[e50] Код';

COMMENT ON COLUMN core.cs_route_statuses.c_name IS '[e40|d] Наименование';

COMMENT ON COLUMN core.cs_route_statuses.c_short_name IS '[e30] Краткое наименование';

COMMENT ON COLUMN core.cs_route_statuses.c_const IS '[e20] Константа';

COMMENT ON COLUMN core.cs_route_statuses.n_order IS '[e10] Приоритет статуса(чем больше число тем выше статус)';

COMMENT ON COLUMN core.cs_route_statuses.b_disabled IS '[e05] Отключено';

--------------------------------------------------------------------------------

CREATE TRIGGER cs_route_statuses_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cs_route_statuses
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cs_route_statuses
	ADD CONSTRAINT cs_route_statuses_pkey PRIMARY KEY (id);
