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

COMMENT ON COLUMN core.cd_route_history.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_route_history.fn_route IS 'Задание';

COMMENT ON COLUMN core.cd_route_history.fn_status IS 'Статус';

COMMENT ON COLUMN core.cd_route_history.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.cd_route_history.d_date IS 'Дата изменения';

COMMENT ON COLUMN core.cd_route_history.c_notice IS 'Примечание';

COMMENT ON COLUMN core.cd_route_history.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX cd_route_history_fn_route_idx ON core.cd_route_history USING btree (fn_route);

--------------------------------------------------------------------------------

CREATE TRIGGER cd_route_history_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_route_history
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

CREATE TRIGGER cd_route_history_cd_routes_f_history_trigger
	AFTER INSERT OR UPDATE OR DELETE ON core.cd_route_history
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_cd_routes_update_history();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_route_history
	ADD CONSTRAINT cd_route_history_pkey PRIMARY KEY (id);
