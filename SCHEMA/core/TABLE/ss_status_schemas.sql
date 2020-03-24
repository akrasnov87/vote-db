CREATE TABLE core.ss_status_schemas (
	id integer DEFAULT nextval('core.auto_id_ss_status_schemas'::regclass) NOT NULL,
	f_start integer NOT NULL,
	f_end integer NOT NULL,
	b_disabled boolean NOT NULL DEFAULT false
);

ALTER TABLE core.ss_status_schemas OWNER TO mobnius;

COMMENT ON TABLE core.ss_status_schemas IS 'Статусная схема';

COMMENT ON COLUMN core.ss_status_schemas.id IS '[e40|d] Идентификатор';

COMMENT ON COLUMN core.ss_status_schemas.f_start IS '[e30] Начальный статус';

COMMENT ON COLUMN core.ss_status_schemas.f_end IS '[e20] Конечный статус';

COMMENT ON COLUMN core.ss_status_schemas.b_disabled IS '[e10] Признак отключенной записи';

--------------------------------------------------------------------------------

CREATE TRIGGER ss_status_schemas_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.ss_status_schemas
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.ss_status_schemas
	ADD CONSTRAINT ss_status_schemas_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.ss_status_schemas
	ADD CONSTRAINT ss_status_schemas_f_end_fkey FOREIGN KEY (f_end) REFERENCES core.cs_route_statuses(id);

--------------------------------------------------------------------------------

ALTER TABLE core.ss_status_schemas
	ADD CONSTRAINT ss_status_schemas_f_start_fkey FOREIGN KEY (f_start) REFERENCES core.cs_route_statuses(id);
