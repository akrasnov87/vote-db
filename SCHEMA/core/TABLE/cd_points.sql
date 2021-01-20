CREATE TABLE core.cd_points (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_registr_pts uuid,
	f_route uuid NOT NULL,
	f_type integer NOT NULL,
	c_notice text,
	c_info text,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now(),
	n_order integer NOT NULL,
	b_anomaly boolean DEFAULT false NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL
);

ALTER TABLE core.cd_points OWNER TO mobnius;

COMMENT ON TABLE core.cd_points IS 'Точки';

COMMENT ON COLUMN core.cd_points.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_points.f_registr_pts IS 'Учетный показатель';

COMMENT ON COLUMN core.cd_points.f_route IS 'Маршрут';

COMMENT ON COLUMN core.cd_points.f_type IS 'Тип точки';

COMMENT ON COLUMN core.cd_points.c_notice IS 'Примечание';

COMMENT ON COLUMN core.cd_points.c_info IS 'Информация';

COMMENT ON COLUMN core.cd_points.jb_data IS 'JSON данные';

COMMENT ON COLUMN core.cd_points.dx_created IS 'Дата создания в БД';

COMMENT ON COLUMN core.cd_points.n_order IS 'Сортировка';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_points_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_points
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_f_route_fkey FOREIGN KEY (f_route) REFERENCES core.cd_routes(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_f_registr_pts_fkey FOREIGN KEY (f_registr_pts) REFERENCES dbo.ed_registr_pts(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_points
	ADD CONSTRAINT cd_points_f_type_fkey FOREIGN KEY (f_type) REFERENCES core.cs_point_types(id);
