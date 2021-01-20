CREATE TABLE dbo.ed_transformers (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_registr_pts uuid,
	b_voltage boolean,
	c_serial_number text,
	d_replace_before date,
	c_phase text,
	imp_int integer,
	n_manufacture_year integer,
	d_check_date date,
	d_replace_date date,
	imp_text text,
	dx_created timestamp with time zone DEFAULT now(),
	f_device_type integer,
	n_rate numeric(10,2)
);

ALTER TABLE dbo.ed_transformers OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_transformers IS 'Трансформаторы';

COMMENT ON COLUMN dbo.ed_transformers.id IS 'ID';

COMMENT ON COLUMN dbo.ed_transformers.f_registr_pts IS 'Ссылка на идентификатор ТУ';

COMMENT ON COLUMN dbo.ed_transformers.b_voltage IS 'Признак, что это ТН';

COMMENT ON COLUMN dbo.ed_transformers.c_serial_number IS 'Серийниый номер';

COMMENT ON COLUMN dbo.ed_transformers.d_replace_before IS 'Дата следующей госповерки';

COMMENT ON COLUMN dbo.ed_transformers.c_phase IS 'Фаза ТТ/ТН';

COMMENT ON COLUMN dbo.ed_transformers.imp_int IS 'Ссылка на идентификатор ТТ/ТН из сторонней системы';

COMMENT ON COLUMN dbo.ed_transformers.n_manufacture_year IS 'Год выпуска';

COMMENT ON COLUMN dbo.ed_transformers.d_check_date IS 'Дата гос.поверки';

COMMENT ON COLUMN dbo.ed_transformers.d_replace_date IS 'Дата сняти прибора (признак отключения)';

COMMENT ON COLUMN dbo.ed_transformers.f_device_type IS 'Ссылка на тип документа';
