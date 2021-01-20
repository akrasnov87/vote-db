CREATE TABLE dbo.sd_subscr (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_division integer,
	f_subdivision integer,
	c_code text,
	c_name1 text,
	c_name2 text,
	c_name3 text,
	c_telephone text,
	b_problem_person boolean DEFAULT false NOT NULL,
	b_person boolean,
	n_check_date integer,
	f_subscr integer,
	imp_int integer,
	jb_history json
);

ALTER TABLE dbo.sd_subscr OWNER TO mobnius;

COMMENT ON TABLE dbo.sd_subscr IS 'Абонент';

COMMENT ON COLUMN dbo.sd_subscr.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.sd_subscr.c_code IS 'Код абонента';

COMMENT ON COLUMN dbo.sd_subscr.c_name1 IS 'Наименование ЮЛ:c_name_consumer | Фамилия ФЛ';

COMMENT ON COLUMN dbo.sd_subscr.c_name2 IS 'Имя ФЛ';

COMMENT ON COLUMN dbo.sd_subscr.c_name3 IS 'Отчество ФЛ';

COMMENT ON COLUMN dbo.sd_subscr.c_telephone IS 'Номер телефона';

COMMENT ON COLUMN dbo.sd_subscr.b_problem_person IS 'Проблемный абонент';

COMMENT ON COLUMN dbo.sd_subscr.b_person IS 'Признак ФЛ';

COMMENT ON COLUMN dbo.sd_subscr.imp_int IS 'временное поле для импорта';

COMMENT ON COLUMN dbo.sd_subscr.jb_history IS 'История изменений номеров телефона';
