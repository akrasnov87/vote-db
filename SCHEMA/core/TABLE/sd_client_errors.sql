CREATE TABLE core.sd_client_errors (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_message text,
	c_code text,
	d_created timestamp with time zone,
	fn_user integer,
	c_version text,
	c_platform text,
	jb_data jsonb,
	dx_date timestamp with time zone DEFAULT now()
);

ALTER TABLE core.sd_client_errors OWNER TO mobnius;

COMMENT ON TABLE core.sd_client_errors IS 'Клиентские ошибки';

COMMENT ON COLUMN core.sd_client_errors.id IS 'Идентификатор';

COMMENT ON COLUMN core.sd_client_errors.c_message IS 'Текст ошибки';

COMMENT ON COLUMN core.sd_client_errors.c_code IS 'Код ошибки';

COMMENT ON COLUMN core.sd_client_errors.d_created IS 'Дата возникновения ошибки';

COMMENT ON COLUMN core.sd_client_errors.fn_user IS 'Идентификатор пользователя';

COMMENT ON COLUMN core.sd_client_errors.c_version IS 'Версия приложения';

COMMENT ON COLUMN core.sd_client_errors.c_platform IS 'Тип платформы';

COMMENT ON COLUMN core.sd_client_errors.jb_data IS 'Прочии данные';

COMMENT ON COLUMN core.sd_client_errors.dx_date IS 'Дата записи на сервере';

--------------------------------------------------------------------------------

ALTER TABLE core.sd_client_errors
	ADD CONSTRAINT sd_client_errors_pkey PRIMARY KEY (id);
