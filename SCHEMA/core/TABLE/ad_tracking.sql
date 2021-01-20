CREATE TABLE core.ad_tracking (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone DEFAULT now() NOT NULL,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_network_status text,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.ad_tracking OWNER TO mobnius;

COMMENT ON TABLE core.ad_tracking IS 'Перемещение исполнителя';

COMMENT ON COLUMN core.ad_tracking.id IS 'Идентификатор';

COMMENT ON COLUMN core.ad_tracking.fn_user IS 'Исполнитель';

COMMENT ON COLUMN core.ad_tracking.d_date IS 'Дата';

COMMENT ON COLUMN core.ad_tracking.n_longitude IS 'Долгота';

COMMENT ON COLUMN core.ad_tracking.n_latitude IS 'Широта';

COMMENT ON COLUMN core.ad_tracking.c_network_status IS 'Тип сети';

COMMENT ON COLUMN core.ad_tracking.dx_created IS 'Создан в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.ad_tracking
	ADD CONSTRAINT ad_tracking_pkey PRIMARY KEY (id);
