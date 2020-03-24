CREATE TABLE core.ad_audits (
	id bigint DEFAULT nextval('core.auto_id_ad_audits'::regclass) NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_data text,
	c_type text NOT NULL,
	c_app_name text NOT NULL,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.ad_audits OWNER TO mobnius;

COMMENT ON TABLE core.ad_audits IS 'Действия пользователя';

COMMENT ON COLUMN core.ad_audits.id IS '[e80|d] Идентификатор';

COMMENT ON COLUMN core.ad_audits.fn_user IS '[e70] Пользователь';

COMMENT ON COLUMN core.ad_audits.d_date IS '[e60] Дата события';

COMMENT ON COLUMN core.ad_audits.c_data IS '[e50] Дополнительные параметры';

COMMENT ON COLUMN core.ad_audits.c_type IS '[e40] Тип события';

COMMENT ON COLUMN core.ad_audits.c_app_name IS '[e20] Имя приложение';

COMMENT ON COLUMN core.ad_audits.dx_created IS '[e10] Создан в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.ad_audits
	ADD CONSTRAINT ad_audits_pkey PRIMARY KEY (id);
