CREATE TABLE core.ad_audits (
	id bigint DEFAULT nextval('core.auto_id_ad_audits'::regclass) NOT NULL,
	fn_user integer,
	d_date timestamp with time zone,
	c_data text,
	c_type text,
	c_app_name text,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.ad_audits OWNER TO mobnius;

COMMENT ON TABLE core.ad_audits IS 'Действия пользователя';

COMMENT ON COLUMN core.ad_audits.id IS 'Идентификатор';

COMMENT ON COLUMN core.ad_audits.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.ad_audits.d_date IS 'Дата события';

COMMENT ON COLUMN core.ad_audits.c_data IS 'Дополнительные параметры';

COMMENT ON COLUMN core.ad_audits.c_type IS 'Тип события';

COMMENT ON COLUMN core.ad_audits.c_app_name IS 'Имя приложение';

COMMENT ON COLUMN core.ad_audits.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.ad_audits
	ADD CONSTRAINT ad_audits_pkey PRIMARY KEY (id);
