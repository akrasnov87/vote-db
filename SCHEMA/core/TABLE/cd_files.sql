CREATE TABLE core.cd_files (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_mime text NOT NULL,
	c_extension text NOT NULL,
	ba_data bytea NOT NULL,
	n_size integer NOT NULL,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_files OWNER TO mobnius;

COMMENT ON TABLE core.cd_files IS 'Файлы';

COMMENT ON COLUMN core.cd_files.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_files.c_name IS 'Имя файла';

COMMENT ON COLUMN core.cd_files.d_date IS 'Дата создания';

COMMENT ON COLUMN core.cd_files.c_mime IS 'MIME-тип';

COMMENT ON COLUMN core.cd_files.c_extension IS 'Расширение';

COMMENT ON COLUMN core.cd_files.ba_data IS 'Байты';

COMMENT ON COLUMN core.cd_files.n_size IS 'Размер файла';

COMMENT ON COLUMN core.cd_files.jb_data IS 'JSON данные';

COMMENT ON COLUMN core.cd_files.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.cd_files
	ADD CONSTRAINT cd_files_pkey PRIMARY KEY (id);
