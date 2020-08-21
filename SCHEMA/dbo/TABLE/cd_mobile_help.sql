CREATE TABLE dbo.cd_mobile_help (
	id uuid NOT NULL,
	c_key text NOT NULL,
	c_html text,
	d_date timestamp with time zone,
	c_title text NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE dbo.cd_mobile_help OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_mobile_help IS 'Справочная информация для мобильного устройства';

COMMENT ON COLUMN dbo.cd_mobile_help.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_mobile_help.c_key IS 'Ключ справки';

COMMENT ON COLUMN dbo.cd_mobile_help.c_html IS 'Содержимое справки';

COMMENT ON COLUMN dbo.cd_mobile_help.d_date IS 'Дата';

COMMENT ON COLUMN dbo.cd_mobile_help.c_title IS 'Заголовок';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_mobile_help
	ADD CONSTRAINT cd_mobile_help_pkey PRIMARY KEY (id);
