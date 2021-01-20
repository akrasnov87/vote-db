CREATE TABLE dbo.ed_registr_pts (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_division integer NOT NULL,
	f_subdivision integer NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean DEFAULT false NOT NULL,
	c_registr_pts text,
	f_status_consume integer,
	b_technical_metering boolean,
	c_substation text,
	c_line_substation text,
	c_rp text,
	c_line_rp text,
	c_tp text,
	c_line_tp text,
	c_line_segment text,
	f_violation integer,
	d_violation_date date,
	d_date_before date,
	f_subscr uuid,
	f_address uuid,
	f_subscr_int integer,
	f_device_int integer,
	imp_int integer,
	c_line_tp_1 text,
	c_line_segment_1 text,
	imp_text text,
	d_close_date date,
	c_status_registr_pts text,
	c_status text,
	c_predictr text
);

ALTER TABLE dbo.ed_registr_pts OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_registr_pts IS 'Учетный показатель';

COMMENT ON COLUMN dbo.ed_registr_pts.id IS 'ID';

COMMENT ON COLUMN dbo.ed_registr_pts.f_division IS 'Филиал/Отделение';

COMMENT ON COLUMN dbo.ed_registr_pts.f_subdivision IS 'Участок';

COMMENT ON COLUMN dbo.ed_registr_pts.b_disabled IS 'Отлючено';

COMMENT ON COLUMN dbo.ed_registr_pts.dx_created IS 'Дата создания';

COMMENT ON COLUMN dbo.ed_registr_pts.sn_delete IS 'Признак что запись удалена';

COMMENT ON COLUMN dbo.ed_registr_pts.c_registr_pts IS 'Наименование точки учета';

COMMENT ON COLUMN dbo.ed_registr_pts.f_status_consume IS 'Статус точки учета';

COMMENT ON COLUMN dbo.ed_registr_pts.b_technical_metering IS 'Признак Тех. Учета';

COMMENT ON COLUMN dbo.ed_registr_pts.c_substation IS 'Подстанция';

COMMENT ON COLUMN dbo.ed_registr_pts.c_line_substation IS 'Фидер 6-10/35кВ';

COMMENT ON COLUMN dbo.ed_registr_pts.c_rp IS 'РП';

COMMENT ON COLUMN dbo.ed_registr_pts.c_line_rp IS 'Фидер 6-10/35кВ';

COMMENT ON COLUMN dbo.ed_registr_pts.c_tp IS 'Трансформаторная подстанция';

COMMENT ON COLUMN dbo.ed_registr_pts.c_line_tp IS 'Фидер 0,4кВ';

COMMENT ON COLUMN dbo.ed_registr_pts.c_line_segment IS '№ опоры ВЛ-0,4кВ';

COMMENT ON COLUMN dbo.ed_registr_pts.f_violation IS 'Ссылка на Тип нарушения';

COMMENT ON COLUMN dbo.ed_registr_pts.d_violation_date IS 'Дата нарушения';

COMMENT ON COLUMN dbo.ed_registr_pts.d_date_before IS 'Срок устранения нарушения';

COMMENT ON COLUMN dbo.ed_registr_pts.f_subscr IS 'Ссылка на абонента';

COMMENT ON COLUMN dbo.ed_registr_pts.f_address IS 'Ссылка на адресную витрину';

COMMENT ON COLUMN dbo.ed_registr_pts.imp_int IS 'временно поле при импорте';

COMMENT ON COLUMN dbo.ed_registr_pts.imp_text IS 'Код УП';

COMMENT ON COLUMN dbo.ed_registr_pts.d_close_date IS 'Дата закрытия ТУ';

COMMENT ON COLUMN dbo.ed_registr_pts.c_status_registr_pts IS 'Статус ТУ';

COMMENT ON COLUMN dbo.ed_registr_pts.c_status IS 'Внеплановые работы';

COMMENT ON COLUMN dbo.ed_registr_pts.c_predictr IS 'Показатель из системы ПредиктР';

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_pkey PRIMARY KEY (id);
