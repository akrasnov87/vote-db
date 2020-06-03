CREATE TABLE core.cd_userinroutes (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_route uuid NOT NULL,
	f_user integer NOT NULL,
	b_main boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_userinroutes OWNER TO mobnius;

COMMENT ON TABLE core.cd_userinroutes IS 'Исполнители задания';

COMMENT ON COLUMN core.cd_userinroutes.id IS '[e50] Идентифиактор';

COMMENT ON COLUMN core.cd_userinroutes.f_route IS '[e40] Маршрут';

COMMENT ON COLUMN core.cd_userinroutes.f_user IS '[e30] Пользователь';

COMMENT ON COLUMN core.cd_userinroutes.b_main IS '[e20] Является главным';

COMMENT ON COLUMN core.cd_userinroutes.dx_created IS '[e10] Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX cd_userinroutes_f_user_idx ON core.cd_userinroutes USING btree (f_user);

--------------------------------------------------------------------------------

CREATE INDEX cd_userinroutes_f_route_idx ON core.cd_userinroutes USING btree (f_route);

--------------------------------------------------------------------------------

CREATE TRIGGER cd_userinroutes_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_userinroutes
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_f_route_fkey FOREIGN KEY (f_route) REFERENCES core.cd_routes(id);
