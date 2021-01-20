CREATE TABLE core.cd_userinroutes (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_route uuid NOT NULL,
	f_user integer NOT NULL,
	b_main boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_userinroutes OWNER TO mobnius;

COMMENT ON TABLE core.cd_userinroutes IS 'Исполнители задания';

COMMENT ON COLUMN core.cd_userinroutes.id IS 'Идентифиактор';

COMMENT ON COLUMN core.cd_userinroutes.f_route IS 'Маршрут';

COMMENT ON COLUMN core.cd_userinroutes.f_user IS 'Пользователь';

COMMENT ON COLUMN core.cd_userinroutes.b_main IS 'Является главным';

COMMENT ON COLUMN core.cd_userinroutes.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_userinroutes_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_userinroutes
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_f_route_fkey FOREIGN KEY (f_route) REFERENCES core.cd_routes(id);
