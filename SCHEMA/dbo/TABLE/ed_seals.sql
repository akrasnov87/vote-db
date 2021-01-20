CREATE TABLE dbo.ed_seals (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_number text NOT NULL,
	f_user integer,
	dx_created timestamp with time zone DEFAULT now(),
	f_registr_pts uuid,
	c_prefix text,
	c_type text,
	c_location text,
	imp_int integer,
	d_replace_date timestamp with time zone,
	b_draft boolean DEFAULT false,
	n_order integer,
	jb_history json,
	f_type integer,
	f_place integer,
	f_output_conn_seal uuid,
	n_number integer
);

ALTER TABLE dbo.ed_seals OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_seals IS 'Плобмы';

COMMENT ON COLUMN dbo.ed_seals.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.ed_seals.c_number IS 'Номер пломбы';

COMMENT ON COLUMN dbo.ed_seals.f_user IS 'Пломба выдана на пользователя';

COMMENT ON COLUMN dbo.ed_seals.dx_created IS 'Дата создания';

COMMENT ON COLUMN dbo.ed_seals.f_registr_pts IS 'Точка ';

COMMENT ON COLUMN dbo.ed_seals.d_replace_date IS 'Дата замены';

COMMENT ON COLUMN dbo.ed_seals.b_draft IS 'Черновик';

COMMENT ON COLUMN dbo.ed_seals.jb_history IS 'История изменений';

COMMENT ON COLUMN dbo.ed_seals.f_type IS 'Типы пломб';

COMMENT ON COLUMN dbo.ed_seals.f_place IS 'Место установки пломбы';

COMMENT ON COLUMN dbo.ed_seals.f_output_conn_seal IS 'Ссылка на результат из мобильного приложения';
