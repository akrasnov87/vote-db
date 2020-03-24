CREATE TABLE core.ad_tracking (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone DEFAULT now() NOT NULL,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_network_status text,
	gx_geodata public.geography,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.ad_tracking OWNER TO mobnius;

COMMENT ON TABLE core.ad_tracking IS 'Перемещение исполнителя';

COMMENT ON COLUMN core.ad_tracking.id IS '[e80] Идентификатор';

COMMENT ON COLUMN core.ad_tracking.fn_user IS '[e70] Исполнитель';

COMMENT ON COLUMN core.ad_tracking.d_date IS '[e60] Дата';

COMMENT ON COLUMN core.ad_tracking.n_longitude IS '[e50] Долгота';

COMMENT ON COLUMN core.ad_tracking.n_latitude IS '[e40] Широта';

COMMENT ON COLUMN core.ad_tracking.c_network_status IS '[e30] Тип сети';

COMMENT ON COLUMN core.ad_tracking.gx_geodata IS '[e20] Географические координаты';

COMMENT ON COLUMN core.ad_tracking.dx_created IS '[e10] Создан в БД';

--------------------------------------------------------------------------------

CREATE INDEX ad_tracking_gx_geodata_index ON core.ad_tracking USING gist (gx_geodata);

--------------------------------------------------------------------------------

CREATE TRIGGER ad_tracking_coordinates_trigger_iu
	BEFORE INSERT OR UPDATE ON core.ad_tracking
	FOR EACH ROW
	EXECUTE PROCEDURE core.cftiu_coordinates_trigger();

--------------------------------------------------------------------------------

ALTER TABLE core.ad_tracking
	ADD CONSTRAINT ad_tracking_pkey PRIMARY KEY (id);
