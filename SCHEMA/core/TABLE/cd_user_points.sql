CREATE TABLE core.cd_user_points (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_point uuid,
	fn_user integer NOT NULL,
	fn_route uuid NOT NULL,
	fn_type integer NOT NULL,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_notice text,
	b_check boolean DEFAULT false NOT NULL,
	jb_data jsonb,
	d_date_check timestamp with time zone,
	dx_created timestamp with time zone DEFAULT now(),
	d_date timestamp with time zone NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.cd_user_points OWNER TO mobnius;

COMMENT ON TABLE core.cd_user_points IS 'Точки';

COMMENT ON COLUMN core.cd_user_points.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_user_points.fn_point IS 'Точка';

COMMENT ON COLUMN core.cd_user_points.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.cd_user_points.fn_route IS 'Маршрут';

COMMENT ON COLUMN core.cd_user_points.fn_type IS 'Тип';

COMMENT ON COLUMN core.cd_user_points.n_longitude IS 'Долгота';

COMMENT ON COLUMN core.cd_user_points.n_latitude IS 'Широта';

COMMENT ON COLUMN core.cd_user_points.c_notice IS 'Примечание';

COMMENT ON COLUMN core.cd_user_points.b_check IS 'Подтверждено';

COMMENT ON COLUMN core.cd_user_points.jb_data IS 'JSON данные';

COMMENT ON COLUMN core.cd_user_points.d_date_check IS 'Дата подтверждения';

COMMENT ON COLUMN core.cd_user_points.dx_created IS 'Дата записи в БД';

COMMENT ON COLUMN core.cd_user_points.d_date IS 'Дата создания';

--------------------------------------------------------------------------------

ALTER TABLE core.cd_user_points
	ADD CONSTRAINT cd_user_points_pkey PRIMARY KEY (id);
