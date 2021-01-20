CREATE TABLE dbo.ed_output_transformers (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_route uuid,
	fn_point uuid,
	fn_user_point uuid,
	fn_result uuid,
	fn_transformer uuid,
	c_number text NOT NULL,
	n_year integer,
	d_date timestamp with time zone NOT NULL,
	n_rate numeric,
	fn_phase integer,
	dx_created timestamp with time zone DEFAULT now(),
	d_date_check timestamp with time zone,
	b_voltage boolean NOT NULL,
	fn_device_type integer NOT NULL,
	b_export boolean DEFAULT false
);

ALTER TABLE dbo.ed_output_transformers OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_output_transformers IS 'Исходящая информация о трансформаторах';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_route IS 'Маршрута';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_point IS 'Точка маршрута';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_user_point IS 'Пользовательский результат';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_result IS 'Результат';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_transformer IS 'Пред. трансформатор';

COMMENT ON COLUMN dbo.ed_output_transformers.c_number IS 'Номер трансформатора';

COMMENT ON COLUMN dbo.ed_output_transformers.n_year IS 'Год выпуска';

COMMENT ON COLUMN dbo.ed_output_transformers.n_rate IS 'Коэффициент трансформации';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_phase IS 'Фаза';

COMMENT ON COLUMN dbo.ed_output_transformers.d_date_check IS 'Дата поверки';

COMMENT ON COLUMN dbo.ed_output_transformers.b_voltage IS 'Является трансформатором напряжения';

COMMENT ON COLUMN dbo.ed_output_transformers.fn_device_type IS 'Тип';

COMMENT ON COLUMN dbo.ed_output_transformers.b_export IS 'Экспортировано';
