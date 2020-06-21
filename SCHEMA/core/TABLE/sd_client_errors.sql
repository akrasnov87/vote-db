CREATE TABLE core.sd_client_errors (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_message text NOT NULL,
	c_code text NOT NULL,
	d_created timestamp with time zone NOT NULL,
	fn_user integer NOT NULL,
	c_version text NOT NULL,
	c_platform text NOT NULL,
	jb_data jsonb,
	dx_date timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE core.sd_client_errors OWNER TO mobnius;

COMMENT ON TABLE core.sd_client_errors IS 'Клиентские ошибки';

COMMENT ON COLUMN core.sd_client_errors.id IS '[e90] Идентификатор';

COMMENT ON COLUMN core.sd_client_errors.c_message IS '[e80] Текст ошибки';

COMMENT ON COLUMN core.sd_client_errors.c_code IS '[e70|d] Код ошибки';

COMMENT ON COLUMN core.sd_client_errors.d_created IS '[e60] Дата возникновения ошибки';

COMMENT ON COLUMN core.sd_client_errors.fn_user IS '[e50] Идентификатор пользователя';

COMMENT ON COLUMN core.sd_client_errors.c_version IS '[e40] Версия приложения';

COMMENT ON COLUMN core.sd_client_errors.c_platform IS '[e30] Тип платформы';

COMMENT ON COLUMN core.sd_client_errors.jb_data IS '[e20] Прочии данные';

COMMENT ON COLUMN core.sd_client_errors.dx_date IS '[e10] Дата записи на сервере';

--------------------------------------------------------------------------------

ALTER TABLE core.sd_client_errors
	ADD CONSTRAINT sd_client_errors_pkey PRIMARY KEY (id);
