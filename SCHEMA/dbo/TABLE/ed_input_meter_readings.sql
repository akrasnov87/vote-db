CREATE TABLE dbo.ed_input_meter_readings (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	n_value_prev numeric(19,6),
	d_date_prev timestamp with time zone,
	n_digit numeric(4,2),
	f_scale integer NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	f_registr_pts uuid NOT NULL,
	f_tariff_zone integer NOT NULL,
	f_energy_type integer,
	f_delivery_method integer,
	d_replace_date timestamp with time zone
);

ALTER TABLE dbo.ed_input_meter_readings OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_input_meter_readings IS 'Показания ПУ';

COMMENT ON COLUMN dbo.ed_input_meter_readings.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.ed_input_meter_readings.n_value_prev IS 'Пред. показание';

COMMENT ON COLUMN dbo.ed_input_meter_readings.d_date_prev IS 'Дата пред. показания';

COMMENT ON COLUMN dbo.ed_input_meter_readings.n_digit IS 'Разрядность';

COMMENT ON COLUMN dbo.ed_input_meter_readings.f_scale IS 'Шкала показания';

COMMENT ON COLUMN dbo.ed_input_meter_readings.dx_created IS 'Дата создания записи';

COMMENT ON COLUMN dbo.ed_input_meter_readings.f_registr_pts IS 'Ссылка на точку учета';

COMMENT ON COLUMN dbo.ed_input_meter_readings.f_tariff_zone IS 'Тарифная зона';

COMMENT ON COLUMN dbo.ed_input_meter_readings.f_energy_type IS 'Ссылка на измеряемый показатель';

COMMENT ON COLUMN dbo.ed_input_meter_readings.f_delivery_method IS 'Ссылка на источик показаний';
