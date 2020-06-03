CREATE TABLE core.cd_points (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_registr_pts uuid NOT NULL,
	f_route uuid NOT NULL,
	c_notice text,
	c_info text,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now(),
	n_order integer NOT NULL
);

ALTER TABLE core.cd_points OWNER TO mobnius;

COMMENT ON TABLE core.cd_points IS 'Точки';

COMMENT ON COLUMN core.cd_points.id IS '[e80] Идентификатор';

COMMENT ON COLUMN core.cd_points.f_registr_pts IS '[e70|d] Учетный показатель';

COMMENT ON COLUMN core.cd_points.f_route IS '[e60] Маршрут';

COMMENT ON COLUMN core.cd_points.c_notice IS '[e50] Примечание';

COMMENT ON COLUMN core.cd_points.c_info IS '[e40] Информация';

COMMENT ON COLUMN core.cd_points.jb_data IS '[e30] JSON данные';

COMMENT ON COLUMN core.cd_points.dx_created IS '[e20] Дата создания в БД';

COMMENT ON COLUMN core.cd_points.n_order IS '[e10] Сортировка';

--------------------------------------------------------------------------------

CREATE INDEX cd_points_f_route_idx ON core.cd_points USING btree (f_route);

--------------------------------------------------------------------------------

CREATE TRIGGER cd_points_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_points
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_f_registr_pts_fkey FOREIGN KEY (f_registr_pts) REFERENCES dbo.ed_registr_pts(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_f_route_fkey FOREIGN KEY (f_route) REFERENCES core.cd_routes(id);
