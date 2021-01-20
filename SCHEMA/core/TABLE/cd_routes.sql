CREATE TABLE core.cd_routes (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_type integer NOT NULL,
	c_number text NOT NULL,
	d_date timestamp with time zone DEFAULT now() NOT NULL,
	d_date_start date NOT NULL,
	d_date_end date NOT NULL,
	c_notice text,
	b_extended boolean NOT NULL,
	d_extended date,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now(),
	n_order integer NOT NULL,
	b_draft boolean DEFAULT false NOT NULL,
	f_status integer
);

ALTER TABLE core.cd_routes OWNER TO mobnius;

COMMENT ON TABLE core.cd_routes IS 'Маршруты';

COMMENT ON COLUMN core.cd_routes.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_routes.f_type IS 'Тип маршрута';

COMMENT ON COLUMN core.cd_routes.c_number IS 'Номер маршрута';

COMMENT ON COLUMN core.cd_routes.d_date IS 'Дата создания';

COMMENT ON COLUMN core.cd_routes.d_date_start IS 'Дата начала выполнения';

COMMENT ON COLUMN core.cd_routes.d_date_end IS 'Дата завершения выполнения';

COMMENT ON COLUMN core.cd_routes.c_notice IS 'Примечание';

COMMENT ON COLUMN core.cd_routes.b_extended IS 'Продлен';

COMMENT ON COLUMN core.cd_routes.d_extended IS 'Продлен до';

COMMENT ON COLUMN core.cd_routes.jb_data IS 'JSON данные';

COMMENT ON COLUMN core.cd_routes.dx_created IS 'Дата создания в БД';

COMMENT ON COLUMN core.cd_routes.n_order IS 'Сортировка';

COMMENT ON COLUMN core.cd_routes.b_draft IS 'Является черновиком';

COMMENT ON COLUMN core.cd_routes.f_status IS 'Статус маршрута';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_routes_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_routes
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_routes
	ADD CONSTRAINT cd_routes_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_routes
	ADD CONSTRAINT cd_routes_f_type_fkey FOREIGN KEY (f_type) REFERENCES core.cs_route_types(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_routes
	ADD CONSTRAINT cd_routes_f_status_fkey FOREIGN KEY (f_status) REFERENCES core.cs_route_statuses(id);
