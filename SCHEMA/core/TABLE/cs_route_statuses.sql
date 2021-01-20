CREATE TABLE core.cs_route_statuses (
	id integer DEFAULT nextval('core.auto_id_cs_route_statuses'::regclass) NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_short_name text,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.cs_route_statuses OWNER TO mobnius;

COMMENT ON TABLE core.cs_route_statuses IS 'Тип результат';

COMMENT ON COLUMN core.cs_route_statuses.id IS 'Идентификатор';

COMMENT ON COLUMN core.cs_route_statuses.n_code IS 'Код';

COMMENT ON COLUMN core.cs_route_statuses.c_name IS 'Наименование';

COMMENT ON COLUMN core.cs_route_statuses.c_short_name IS 'Краткое наименование';

COMMENT ON COLUMN core.cs_route_statuses.c_const IS 'Константа';

COMMENT ON COLUMN core.cs_route_statuses.n_order IS 'Приоритет статуса (чем больше число тем выше статус)';

COMMENT ON COLUMN core.cs_route_statuses.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

CREATE TRIGGER cs_route_statuses_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cs_route_statuses
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cs_route_statuses
	ADD CONSTRAINT cs_route_statuses_pkey PRIMARY KEY (id);
