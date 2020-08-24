CREATE TABLE core.cd_user_points (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_point uuid,
	fn_user integer NOT NULL,
	fn_route uuid NOT NULL,
	fn_type integer NOT NULL,
	jb_tel jsonb,
	jb_email jsonb,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	gx_geodata public.geography,
	c_notice text,
	b_check boolean DEFAULT false NOT NULL,
	jb_data jsonb,
	d_date_check timestamp with time zone,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	d_date timestamp with time zone NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.cd_user_points OWNER TO mobnius;

COMMENT ON TABLE core.cd_user_points IS 'Точки';

COMMENT ON COLUMN core.cd_user_points.id IS '[e160] Идентификатор';

COMMENT ON COLUMN core.cd_user_points.fn_point IS '[e150|d] Точка';

COMMENT ON COLUMN core.cd_user_points.fn_user IS '[e140] Пользователь';

COMMENT ON COLUMN core.cd_user_points.fn_route IS '[e130] Маршрут';

COMMENT ON COLUMN core.cd_user_points.fn_type IS '[e120] Тип';

COMMENT ON COLUMN core.cd_user_points.jb_tel IS '[e110] Номер телефона';

COMMENT ON COLUMN core.cd_user_points.jb_email IS '[e100] Эл. почта';

COMMENT ON COLUMN core.cd_user_points.n_longitude IS '[e90] Долгота';

COMMENT ON COLUMN core.cd_user_points.n_latitude IS '[e80] Широта';

COMMENT ON COLUMN core.cd_user_points.gx_geodata IS '[e70] Вычисляемое поле';

COMMENT ON COLUMN core.cd_user_points.c_notice IS '[e60] Примечание';

COMMENT ON COLUMN core.cd_user_points.b_check IS '[e50] Подтверждено';

COMMENT ON COLUMN core.cd_user_points.jb_data IS '[e40] JSON данные';

COMMENT ON COLUMN core.cd_user_points.d_date_check IS '[e30] Дата подтверждения';

COMMENT ON COLUMN core.cd_user_points.dx_created IS '[e20] Дата записи в БД';

COMMENT ON COLUMN core.cd_user_points.d_date IS '[e10] Дата создания';

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_user_fn_route_idx ON core.cd_user_points USING btree (fn_user, fn_route);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_route_idx ON core.cd_user_points USING btree (fn_route);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_point_idx ON core.cd_user_points USING btree (fn_point);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_user_fn_route_d_date_idx ON core.cd_user_points USING btree (fn_user, fn_route, d_date);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_user_idx ON core.cd_user_points USING btree (fn_user);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_d_date_idx ON core.cd_user_points USING btree (d_date DESC NULLS LAST);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_b_disabled_idx ON core.cd_user_points USING btree (b_disabled);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_user_b_disabled_idx ON core.cd_user_points USING btree (fn_user, b_disabled);

--------------------------------------------------------------------------------

CREATE INDEX cd_user_points_fn_route_fn_point_idx ON core.cd_user_points USING btree (fn_route, fn_point);

--------------------------------------------------------------------------------

CREATE TRIGGER cd_user_points_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_user_points
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

CREATE TRIGGER cd_user_points_trigger
	BEFORE INSERT OR UPDATE ON core.cd_user_points
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_cd_user_points_trigger();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_user_points
	ADD CONSTRAINT cd_user_points_pkey PRIMARY KEY (id);
