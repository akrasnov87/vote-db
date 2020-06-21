CREATE TABLE core.ad_mobile_devices (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone NOT NULL,
	b_debug boolean DEFAULT false NOT NULL,
	c_architecture text,
	c_phone_model text,
	c_sdk text,
	c_os text,
	c_imei text,
	c_application_version text,
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE core.ad_mobile_devices OWNER TO mobnius;

COMMENT ON TABLE core.ad_mobile_devices IS 'Информация о мобильных устройствах';

COMMENT ON COLUMN core.ad_mobile_devices.id IS '[e110] Идентификатор';

COMMENT ON COLUMN core.ad_mobile_devices.fn_user IS '[e100] Пользователь';

COMMENT ON COLUMN core.ad_mobile_devices.d_date IS '[e90] Дата возникновения событий';

COMMENT ON COLUMN core.ad_mobile_devices.b_debug IS '[e80] Режим отладки';

COMMENT ON COLUMN core.ad_mobile_devices.c_architecture IS '[e70] Архитектура устройства';

COMMENT ON COLUMN core.ad_mobile_devices.c_phone_model IS '[e60] Модель телефона';

COMMENT ON COLUMN core.ad_mobile_devices.c_sdk IS '[e50] Версия sdk';

COMMENT ON COLUMN core.ad_mobile_devices.c_os IS '[e40] Версия ОС';

COMMENT ON COLUMN core.ad_mobile_devices.c_imei IS '[e30] IMEI';

COMMENT ON COLUMN core.ad_mobile_devices.c_application_version IS '[e20] Версия приложения';

COMMENT ON COLUMN core.ad_mobile_devices.dx_created IS '[e10] Создан в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.ad_mobile_devices
	ADD CONSTRAINT ad_mobile_devices_pkey PRIMARY KEY (id);
