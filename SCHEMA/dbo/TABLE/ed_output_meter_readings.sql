CREATE TABLE dbo.ed_output_meter_readings (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_meter_reading uuid NOT NULL,
	fn_point uuid,
	fn_route uuid,
	fn_user_point uuid,
	n_value numeric(19,6),
	d_date timestamp with time zone NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	b_export boolean DEFAULT false
);

ALTER TABLE dbo.ed_output_meter_readings OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_output_meter_readings IS 'Показания ПУ';

COMMENT ON COLUMN dbo.ed_output_meter_readings.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.ed_output_meter_readings.fn_meter_reading IS 'Показание ПУ';

COMMENT ON COLUMN dbo.ed_output_meter_readings.fn_point IS 'Точка маршрута';

COMMENT ON COLUMN dbo.ed_output_meter_readings.fn_route IS 'Маршрута';

COMMENT ON COLUMN dbo.ed_output_meter_readings.fn_user_point IS 'Пользовательская точка';

COMMENT ON COLUMN dbo.ed_output_meter_readings.n_value IS 'Показание';

COMMENT ON COLUMN dbo.ed_output_meter_readings.d_date IS 'Дата показания';

COMMENT ON COLUMN dbo.ed_output_meter_readings.dx_created IS 'Дата создания записи';
