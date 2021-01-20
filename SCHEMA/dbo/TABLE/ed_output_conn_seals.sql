CREATE TABLE dbo.ed_output_conn_seals (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_seal uuid,
	fn_point uuid NOT NULL,
	fn_route uuid NOT NULL,
	fn_user_point uuid NOT NULL,
	fn_seal_new uuid NOT NULL,
	fn_type integer,
	fn_place integer,
	d_date timestamp with time zone NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	fn_result uuid NOT NULL,
	b_export boolean DEFAULT false
);

ALTER TABLE dbo.ed_output_conn_seals OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_output_conn_seals IS 'Привязка новых пломб к точке учета';

COMMENT ON COLUMN dbo.ed_output_conn_seals.id IS '[e110] Идентификатор';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_seal IS 'Ссылка на пред. пломбу';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_point IS '[e90] Точка маршрута';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_route IS '[e80] Маршрута';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_user_point IS '[e70] Пользовательская точка';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_seal_new IS '[e50|d] Новая пломба';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_type IS '[e40] Тип пломбы';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_place IS '[e30] Место установки';

COMMENT ON COLUMN dbo.ed_output_conn_seals.d_date IS '[e20] Дата';

COMMENT ON COLUMN dbo.ed_output_conn_seals.dx_created IS '[e10] Дата создания записи';

COMMENT ON COLUMN dbo.ed_output_conn_seals.fn_result IS 'Результат';
