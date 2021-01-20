CREATE TABLE dbo.ed_blanks (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_result_type integer NOT NULL,
	c_number text NOT NULL,
	f_user integer NOT NULL,
	b_use boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	fn_result uuid,
	jb_history json,
	b_draft boolean DEFAULT false NOT NULL,
	n_order integer,
	c_prefix text,
	n_number integer
);

ALTER TABLE dbo.ed_blanks OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_blanks IS 'Бланки строгой отчетности';

COMMENT ON COLUMN dbo.ed_blanks.f_result_type IS 'Тип результата к которому привязан бланк';

COMMENT ON COLUMN dbo.ed_blanks.c_number IS 'Номер бланка';

COMMENT ON COLUMN dbo.ed_blanks.f_user IS 'Пользователь к которому привязан бланк';

COMMENT ON COLUMN dbo.ed_blanks.b_use IS 'Использовано';

COMMENT ON COLUMN dbo.ed_blanks.dx_created IS 'Дата создания';

COMMENT ON COLUMN dbo.ed_blanks.jb_history IS 'История изменения';

COMMENT ON COLUMN dbo.ed_blanks.b_draft IS 'Черновик';
