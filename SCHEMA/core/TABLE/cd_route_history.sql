CREATE TABLE core.cd_route_history (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_route uuid NOT NULL,
	fn_status integer NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_notice text,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_route_history OWNER TO mobnius;

COMMENT ON TABLE core.cd_route_history IS 'История изменения статусов заданий';

COMMENT ON COLUMN core.cd_route_history.id IS '[e70] Идентификатор';

COMMENT ON COLUMN core.cd_route_history.fn_route IS '[e60] Задание';

COMMENT ON COLUMN core.cd_route_history.fn_status IS '[e50|d] Статус';

COMMENT ON COLUMN core.cd_route_history.fn_user IS '[e40] Пользователь';

COMMENT ON COLUMN core.cd_route_history.d_date IS '[e30] Дата изменения';

COMMENT ON COLUMN core.cd_route_history.c_notice IS '[e20] Примечание';

COMMENT ON COLUMN core.cd_route_history.dx_created IS '[e10] Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX cd_route_history_fn_status_fn_route ON core.cd_route_history USING btree (fn_status, fn_route);

--------------------------------------------------------------------------------

CREATE TRIGGER cd_route_history_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_route_history
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_route_history
	ADD CONSTRAINT cd_route_history_pkey PRIMARY KEY (id);
