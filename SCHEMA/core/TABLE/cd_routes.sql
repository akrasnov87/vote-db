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
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	n_order integer NOT NULL,
	f_house uuid
);

ALTER TABLE core.cd_routes OWNER TO mobnius;

COMMENT ON TABLE core.cd_routes IS 'Маршруты';

COMMENT ON COLUMN core.cd_routes.id IS '[e120] Идентификатор';

COMMENT ON COLUMN core.cd_routes.f_type IS '[e110] Тип маршрута';

COMMENT ON COLUMN core.cd_routes.c_number IS '[e100|d] Номер маршрута';

COMMENT ON COLUMN core.cd_routes.d_date IS '[e90] Дата создания';

COMMENT ON COLUMN core.cd_routes.d_date_start IS '[e80] Дата начала выполнения';

COMMENT ON COLUMN core.cd_routes.d_date_end IS '[e70] Дата завершения выполнения';

COMMENT ON COLUMN core.cd_routes.c_notice IS '[e60] Примечание';

COMMENT ON COLUMN core.cd_routes.b_extended IS '[e50] Продлен';

COMMENT ON COLUMN core.cd_routes.d_extended IS '[e40] Продлен до';

COMMENT ON COLUMN core.cd_routes.jb_data IS '[e30] JSON данные';

COMMENT ON COLUMN core.cd_routes.dx_created IS '[e20] Дата создания в БД';

COMMENT ON COLUMN core.cd_routes.n_order IS '[e10] Сортировка';

COMMENT ON COLUMN core.cd_routes.f_house IS 'Ссылка на дом';

--------------------------------------------------------------------------------

CREATE INDEX cd_routes_d_date_end_idx ON core.cd_routes USING btree (d_date_end);

--------------------------------------------------------------------------------

CREATE TRIGGER cd_routes_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_routes
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_routes
	ADD CONSTRAINT cd_routes_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_routes
	ADD CONSTRAINT cd_routes_f_type_fkey FOREIGN KEY (f_type) REFERENCES core.cs_route_types(id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_routes
	ADD CONSTRAINT cd_routes_f_house_fkey FOREIGN KEY (f_house) REFERENCES dbo.cs_house(id);
