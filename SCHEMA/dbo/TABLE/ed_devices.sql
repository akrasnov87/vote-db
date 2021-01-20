CREATE TABLE dbo.ed_devices (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	link integer,
	f_device_type integer,
	c_serial_number text,
	n_rate numeric(19,6),
	n_manufacture_year integer,
	d_setup_date date,
	d_valid_date date,
	f_device_location integer,
	f_owner_type integer,
	n_owner_type integer,
	c_device_location text,
	imp_int integer,
	f_registr_pts uuid,
	imp_text text,
	b_askue boolean DEFAULT false,
	d_close_date date
);

ALTER TABLE dbo.ed_devices OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_devices IS 'Учетный показатель';

COMMENT ON COLUMN dbo.ed_devices.id IS 'ID';

COMMENT ON COLUMN dbo.ed_devices.link IS 'Идентификтор из Омнис';

COMMENT ON COLUMN dbo.ed_devices.c_serial_number IS 'Серийный номер ПУ';

COMMENT ON COLUMN dbo.ed_devices.n_rate IS 'Коэффициент трансформации';

COMMENT ON COLUMN dbo.ed_devices.n_manufacture_year IS 'Год выпуска';

COMMENT ON COLUMN dbo.ed_devices.d_setup_date IS 'Дата установки';

COMMENT ON COLUMN dbo.ed_devices.d_valid_date IS 'Дата гос. поверки';

COMMENT ON COLUMN dbo.ed_devices.f_device_location IS 'Ссылка на Справочник в Омнис Место установки';

COMMENT ON COLUMN dbo.ed_devices.f_owner_type IS 'Ссылка на Справочник в Омнис Эксплуатационная ответственность';

COMMENT ON COLUMN dbo.ed_devices.n_owner_type IS 'Эксплуатационная ответственность';

COMMENT ON COLUMN dbo.ed_devices.c_device_location IS 'временное поле. т.к. в присланных данных более 700 строк по 1 РЭС';

COMMENT ON COLUMN dbo.ed_devices.imp_int IS 'временно поле при импорте';

COMMENT ON COLUMN dbo.ed_devices.f_registr_pts IS 'Ссылка на ТУ';

COMMENT ON COLUMN dbo.ed_devices.b_askue IS 'ПУ включен в АСКУЭ';

COMMENT ON COLUMN dbo.ed_devices.d_close_date IS 'Дата снятия ПУ';
