CREATE TABLE core.cd_attachments (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_type integer NOT NULL,
	fn_result uuid NOT NULL,
	fn_route uuid NOT NULL,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_notice text,
	d_date timestamp with time zone NOT NULL,
	fn_file uuid NOT NULL,
	ba_data bytea,
	n_size integer,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now(),
	fn_point uuid
);

ALTER TABLE core.cd_attachments OWNER TO mobnius;

COMMENT ON TABLE core.cd_attachments IS 'Файлы';

COMMENT ON COLUMN core.cd_attachments.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_attachments.fn_type IS 'Тип изображения';

COMMENT ON COLUMN core.cd_attachments.fn_result IS 'Результат';

COMMENT ON COLUMN core.cd_attachments.fn_route IS 'Маршрут';

COMMENT ON COLUMN core.cd_attachments.n_longitude IS 'Долгота';

COMMENT ON COLUMN core.cd_attachments.n_latitude IS 'Широта';

COMMENT ON COLUMN core.cd_attachments.c_notice IS 'Примечание';

COMMENT ON COLUMN core.cd_attachments.d_date IS 'Дата создания';

COMMENT ON COLUMN core.cd_attachments.fn_file IS 'Файл';

COMMENT ON COLUMN core.cd_attachments.ba_data IS 'Превью';

COMMENT ON COLUMN core.cd_attachments.n_size IS 'Размер превью';

COMMENT ON COLUMN core.cd_attachments.jb_data IS 'JSON данные';

COMMENT ON COLUMN core.cd_attachments.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.cd_attachments
	ADD CONSTRAINT cd_attachments_pkey PRIMARY KEY (id);
